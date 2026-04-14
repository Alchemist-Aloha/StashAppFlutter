# Design Spec: GitHub Pages Deployment for StashFlow

This document outlines the strategy for hosting the Flutter web version of StashFlow on GitHub Pages, integrated into the existing release workflows.

## 1. Objective
Enable automated deployment of the Flutter web build to a dedicated `gh-pages` branch whenever a release or nightly build is triggered.

## 2. Architecture & Components

### 2.1 Deployment Target
- **Branch:** `gh-pages`
- **Hosting URL:** `https://<github-user>.github.io/StashFlow/`
- **Base HREF:** `/StashFlow/` (Required for GitHub Pages sub-directory hosting)

### 2.2 Workflow Integration
The deployment logic will be added to two existing workflows:
1.  `.github/workflows/release.yml` (Triggers on version tags `v*`)
2.  `.github/workflows/nightly-release.yml` (Triggers on schedule or push to `dev`)

### 2.3 Tools & Actions
- **Flutter Web Build:** `flutter build web --release --base-href /StashFlow/`
- **Deployment Action:** `peaceiris/actions-gh-pages@v4`

## 3. Implementation Details

### 3.1 Permissions
The workflows require expanded permissions to push to the repository:
```yaml
permissions:
  contents: write
  pages: write
  id-token: write
```

### 3.2 Build Step Modification
The web build command will be updated to include the `--base-href` flag:
```bash
if [ "${{ matrix.target }}" = "web" ]; then
  flutter build web --release --base-href /StashFlow/
fi
```

### 3.3 Deployment Step
A new step will be added to the `build` job, running only for the `web` target:
```yaml
- name: Deploy to GitHub Pages
  if: matrix.target == 'web'
  uses: peaceiris/actions-gh-pages@v4
  with:
    github_token: ${{ secrets.GITHUB_TOKEN }}
    publish_dir: ./build/web
    user_name: 'github-actions[bot]'
    user_email: 'github-actions[bot]@users.noreply.github.com'
    commit_message: "Deploy to GitHub Pages: ${{ github.sha }}"
```

## 4. Verification Plan

### 4.1 Automated Validation
- Verify YAML syntax using `python3 -c "import yaml; ..."`
- Check that the `gh-pages` branch is created/updated after the first successful run.

### 4.2 Manual Validation
- Navigate to `https://<github-user>.github.io/StashFlow/` after deployment.
- Verify that assets (icons, scripts) load correctly (no 404s).
- Confirm the app is interactive and matches the latest build.

## 5. Rollback Plan
- If deployment fails, the `gh-pages` branch can be manually reverted to a previous commit.
- The deployment step can be commented out or removed from the workflow files.
