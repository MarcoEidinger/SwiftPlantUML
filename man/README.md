The man page in this folder was generated with a Swift Package Plugin from `ArgumentParser` (1.1.4):

```bash
# single page
swift package plugin generate-manual
```

FYI: (alternative) to generate a man page for each subcommand: `swift package plugin generate-manual --multi-page`

The man page will automatically be copied to `/usr/local/share/man/man1/` when running `make install`.

The reason why the man page is checked-in and not generated during `make install` is that I don't want to make Xcode 13.3 (= Swift 5.6 in which SPM introduced plugins) as a requirement for installation.

**IMPORTANT**: `ArgumentParser@1.1.4` requires Xcode 13 (Swift 5.5) => macOS 11.3+ so if building from source shall be supported for lower platform versions, e.g. macOS 10.5.4, then revert the `Package.swift` and the dependency declaration to `ArgumentParser` once the man page was generated.

