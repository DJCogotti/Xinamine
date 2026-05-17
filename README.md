# Moeite

`Moeite` is a Theos tweak that adds compatibility for Xina-patched tweaks in Dopamine.

## What does this project do?

- Builds a rootless Debian package for iOS
- Supports `iphoneos-arm64e` devices such as iPhone 12 Pro Max on iOS 16.x
- Fixes package architecture issues and updates metadata for correct installation

## Project structure

- `Makefile` - main Makefile to build the Theos package
- `control` - Debian package metadata
- `Tweak/Makefile` - Theos tweak build configuration
- `Tweak/Sources/` - tweak source files
- `packages/` - output `.deb` package after a successful build

## Requirements

- Theos installed and accessible via `$(HOME)/theos` or the `THEOS` environment variable
- iPhoneOS SDK available in `$(THEOS)/sdks/iPhoneOS16.5.sdk`
- `dpkg` / `apt` on the jailbreak device for installation
- An iOS device with `arm64e` support (for example iPhone 12 Pro Max) and a compatible jailbreak

## Important metadata

- Package ID: `emt.moeite.xinamine`
- Name: `Moeite`
- Version: `0.0.1`
- Architecture: `iphoneos-arm64e`
- Depends: `ellekit`, `oldabi | cy+cpu.arm64`, `firmware (>= 15.0)`

## Build and install

1. Open a terminal in the project root:

```bash
cd /workspaces/Xinamine
```

2. Check that Theos and the SDK are available:

```bash
echo $THEOS
ls "$THEOS/sdks/iPhoneOS16.5.sdk"
```

3. Build the package:

```bash
make package
```

4. After a successful build, the `.deb` is available at:

```bash
packages/emt.moeite.xinamine_0.0.1_iphoneos-arm64e.deb
```

5. Copy the `.deb` to your device and install it with `dpkg -i`:

```bash
dpkg -i /path/to/emt.moeite.xinamine_0.0.1_iphoneos-arm64e.deb
```

6. Reboot the device or refresh the tweak environment if needed.

## Troubleshooting

- `package name has characters that aren't lowercase alphanums or '-+.'`:
  - Use only lowercase letters, digits, `.` `-` or `+` in `control`
- `package architecture does not match system`:
  - Verify that `Architecture` in `control` is set to `iphoneos-arm64e`
- If `Theos` is missing:
  - Set `THEOS` to your Theos installation path or install Theos first

## Changing the name and package ID

- To change the visible display name, edit `Name:` in `control`
- To change the internal package ID, edit `Package:` in `control`

## Recommended workflow

1. Update file names and metadata in `control`
2. Build with `make package`
3. Test on your iPhone with `dpkg -i`
4. Repeat for fixes

## Visual guide

Below are example illustrations you can use in the README or other documentation.

### Theos build output

![Theos build output](assets/theos-build.svg)

### Control metadata

![Control metadata](assets/control-metadata.svg)

### Device installation

![Device installation](assets/install-ios.svg)

### Architecture mismatch error

![Architecture mismatch error](assets/error-architecture.svg)

### Project structure

![Project structure](assets/file-structure.svg)

---

*Note:* The package file name is derived from `Package`, `Version`, and `Architecture`, so a correct `Package:` value prevents installation issues.
