The man page in this folder was generated with a Swift Package Plugin from `ArgumentParser`:

```bash
# single page
swift package plugin generate-manual
```

FYI: (alternative) to generate a man page for each subcommand: `swift package plugin generate-manual --multi-page`

The man page will automatically be copied to `/usr/local/share/man/man1/` when running `make install`.

The reason why the man page is checked-in and not generated during `make install` is that I don't want to make Xcode 13.3 (= Swift 5.6 in which SPM introduced plugins) as a requirement for installation.


