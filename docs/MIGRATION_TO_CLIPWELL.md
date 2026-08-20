# Migrating to Clipwell

**Clipwell** is the canonical identity for the application, bundle, project, release artifacts, public website, and source repository.

| Surface | Canonical value |
|---|---|
| Application and Xcode scheme | `Clipwell` |
| Bundle identifier | `com.lionel.Clipwell` |
| Source repository | <https://github.com/lioneltchami/clipwell> |
| Public website | <https://lioneltchami.github.io/clipwell/> |
| Automation URL scheme | `clipwell://` |
| Release artifact | `Clipwell-<version>-arm64.dmg` |

The previous `bettercapture://` and `captureforge://` automation schemes remain registered as compatibility bridges. They support the same `toggle`, `toggle-copy`, and `open-recordings` actions as `clipwell://` and may be retired only in a documented future major release.

Changing the bundle identifier creates a new macOS application identity. Users moving from an earlier build must install Clipwell and grant its Screen Recording, Camera, and Microphone permissions under the new identity. The app intentionally retains legacy URL automation links but does not claim an automatic migration of macOS privacy grants or preferences between bundle identifiers.

All user-facing release links must use the Clipwell repository and GitHub Pages URL listed above. Historical references to previous project names belong only in migration notes or release history.
