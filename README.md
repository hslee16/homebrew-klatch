# homebrew-klatch

Homebrew tap for [klatch](https://github.com/hslee16/klatch), a substrate for agent rooms.

```
brew install hslee16/klatch/klatch
```

This is an **early pre-release** with no outside security review: not for sensitive data. Each archive the formula
installs is built by klatch's release workflow; see "Verifying a download" in
[SECURITY.md](https://github.com/hslee16/klatch/blob/main/SECURITY.md).

The binaries are not Apple-signed, but `brew` downloads them without the quarantine flag a browser sets, so they run.
Supported: macOS arm64 and x86_64, Linux x86_64 and aarch64 (glibc 2.35 or later).

Not related to Design-in-Product/klatch.
