#!/usr/bin/env bash
# Build the Linux RPM directly. flutter_distributor's rpm maker is broken on
# rpm >= 6: its %install uses relative paths but rpm 6 runs %install from a
# per-package build subdir, and flutter_app_packager 0.6.11 (latest) is
# unmaintained with no config lever to fix it. This mirrors its flow with a
# corrected spec. deb/appimage still go through flutter_distributor.
set -euo pipefail
cd "$(dirname "$0")/.."

yaml_get() { sed -n "s/^$1: *//p" linux/packaging/rpm/make_config.yaml | head -1; }

NAME=$(yaml_get package_name)
DISPLAY_NAME=$(yaml_get display_name)
ICON=$(yaml_get icon)
SUMMARY=$(yaml_get summary)
PACKAGER=$(yaml_get packager)
PACKAGER_EMAIL=$(yaml_get packager_email)
LICENSE=$(yaml_get license)
URL=$(yaml_get url)
ARCH=$(uname -m)

VERSION=$(grep -m1 '^version:' pubspec.yaml | sed 's/version: *//')
VER=${VERSION%+*}
REL=${VERSION#*+}

flutter build linux --release

OUT=dist/$VERSION
TOPDIR=$PWD/dist/$VERSION/rpmbuild
rm -rf "$TOPDIR"
mkdir -p "$TOPDIR"/BUILD/"$NAME" "$TOPDIR"/SPECS "$TOPDIR"/RPMS/"$ARCH" "$TOPDIR"/SOURCES

# stage bundle
cp -r build/linux/x64/release/bundle/. "$TOPDIR/BUILD/$NAME/"
BINARY=$(basename "$(find "$TOPDIR/BUILD/$NAME" -maxdepth 1 -type f | head -1)")

# sanitize rpaths: build-machine paths -> $ORIGIN; keep system paths (e.g. JVM)
for so in "$TOPDIR/BUILD/$NAME"/lib/*.so; do
  rpath=$(patchelf --print-rpath "$so")
  new=$(echo "$rpath" | tr ':' '\n' | while read -r e; do
    case "$e" in "$PWD"/*) echo '$ORIGIN' ;; *) echo "$e" ;; esac
  done | sort -u | paste -sd:)
  [[ "$rpath" != "$new" ]] && patchelf --set-rpath "$new" "$so"
done

cp "$ICON" "$TOPDIR/BUILD/$NAME.png"
cat > "$TOPDIR/BUILD/$NAME.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=$DISPLAY_NAME
GenericName=Stash client
Icon=$NAME
Exec=$NAME %U
Categories=Video;AudioVideo;
StartupNotify=true
EOF

cat > "$TOPDIR/SPECS/$NAME.spec" <<EOF
Name: $NAME
Version: $VER
Release: $REL%{?dist}
Summary: $SUMMARY
License: $LICENSE
URL: $URL
Packager: $PACKAGER <$PACKAGER_EMAIL>
BuildArch: $ARCH

%description
$SUMMARY

%install
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}%{_datadir}/%{name}
mkdir -p %{buildroot}%{_datadir}/applications
mkdir -p %{buildroot}%{_datadir}/pixmaps
cp -r %{_topdir}/BUILD/%{name}/* %{buildroot}%{_datadir}/%{name}
ln -s %{_datadir}/%{name}/$BINARY %{buildroot}%{_bindir}/%{name}
cp %{_topdir}/BUILD/%{name}.desktop %{buildroot}%{_datadir}/applications/%{name}.desktop
cp %{_topdir}/BUILD/%{name}.png %{buildroot}%{_datadir}/pixmaps/%{name}.png

%post
update-desktop-database %{_datadir}/applications &> /dev/null || :

%files
%{_bindir}/%{name}
%{_datadir}/%{name}
%{_datadir}/applications/%{name}.desktop
%{_datadir}/pixmaps/%{name}.png

%defattr(-,root,root)
EOF

rpmbuild --define "_topdir $TOPDIR" -bb "$TOPDIR/SPECS/$NAME.spec"
cp "$TOPDIR"/RPMS/"$ARCH"/*.rpm "$OUT/StashFlow-$VERSION-linux.rpm"
rm -rf "$TOPDIR"
echo "Built $OUT/StashFlow-$VERSION-linux.rpm"
