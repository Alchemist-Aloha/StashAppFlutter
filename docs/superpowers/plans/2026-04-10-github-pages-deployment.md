# GitHub Pages Deployment Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Automate the deployment of the StashFlow Flutter web build to GitHub Pages (`gh-pages` branch) via existing release and nightly workflows.

**Architecture:** Update existing build matrix workflows to include the `--base-href` flag for web builds and a conditional deployment step that pushes the build output to a dedicated branch.

**Tech Stack:** GitHub Actions, Flutter, `peaceiris/actions-gh-pages@v4`.

---

### Task 1: Update Release Workflow

**Files:**
- Modify: `.github/workflows/release.yml`

- [ ] **Step 1: Update permissions and build command**

Update the `permissions` block to include `pages` and `id-token`, and modify the web build command.

```yaml
    permissions:
      contents: write
      pages: write
      id-token: write
...
          elif [ "${{ matrix.target }}" = "web" ]; then
            flutter build web --release --base-href /StashFlow/
          elif [ "${{ matrix.target }}" = "macos" ]; then
```

- [ ] **Step 2: Add deployment step**

Add the deployment step after the web packaging step.

```yaml
      - name: Package Web
        if: matrix.target == 'web'
        run: |
          cd build/web
          zip -r ../../StashFlow-web.zip .
        shell: bash

      - name: Deploy to GitHub Pages
        if: matrix.target == 'web'
        uses: peaceiris/actions-gh-pages@v4
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./build/web
          user_name: 'github-actions[bot]'
          user_email: 'github-actions[bot]@users.noreply.github.com'
          commit_message: "Deploy to GitHub Pages: ${{ github.sha }}"

      - name: Package macOS
```

- [ ] **Step 3: Verify YAML syntax**

Run: `python3 -c "import yaml; yaml.safe_load(open('.github/workflows/release.yml'))"`
Expected: No output (success)

- [ ] **Step 4: Commit**

```bash
git add .github/workflows/release.yml
git commit -m "feat(ci): add github pages deployment to release workflow"
```

---

### Task 2: Update Nightly Release Workflow

**Files:**
- Modify: `.github/workflows/nightly-release.yml`

- [ ] **Step 1: Update permissions and build command**

```yaml
    permissions:
      contents: write
      pages: write
      id-token: write
...
          elif [ "${{ matrix.target }}" = "web" ]; then
            flutter build web --release --base-href /StashFlow/
          elif [ "${{ matrix.target }}" = "macos" ]; then
```

- [ ] **Step 2: Add deployment step**

```yaml
      - name: Package Web
        if: matrix.target == 'web'
        run: |
          cd build/web
          zip -r ../../StashFlow-web-nightly.zip .
        shell: bash

      - name: Deploy to GitHub Pages
        if: matrix.target == 'web'
        uses: peaceiris/actions-gh-pages@v4
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./build/web
          user_name: 'github-actions[bot]'
          user_email: 'github-actions[bot]@users.noreply.github.com'
          commit_message: "Deploy Nightly to GitHub Pages: ${{ github.sha }}"

      - name: Package macOS
```

- [ ] **Step 3: Verify YAML syntax**

Run: `python3 -c "import yaml; yaml.safe_load(open('.github/workflows/nightly-release.yml'))"`
Expected: No output (success)

- [ ] **Step 4: Commit**

```bash
git add .github/workflows/nightly-release.yml
git commit -m "feat(ci): add github pages deployment to nightly workflow"
```
