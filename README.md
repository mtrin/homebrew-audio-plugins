# Audio Plugins

Homebrew tap for macOS audio plugins (VST3, VST2).

## Install

```bash
brew tap mtrin/audio-plugins
brew install --cask airwindows-consolidated
```

## Update

```bash
brew update
brew upgrade --cask airwindows-consolidated
```

## Available Casks

- **airwindows-consolidated** - [Airwindows Consolidated](https://github.com/baconpaul/airwin2rack) VST3 plugin + 478 standalone [Airwindows](https://www.airwindows.com/) VST2 plugins

## Why Casks?

Audio plugins install to system locations (`/Library/Audio/Plug-Ins/`) which require root privileges. Homebrew Formulas cannot use sudo by design, but Casks can request elevated permissions when installing to non-writable locations.

### Plugin locations

| Format | Location |
|--------|----------|
| VST3 | `/Library/Audio/Plug-Ins/VST3/` |
| VST2 | `/Library/Audio/Plug-Ins/VST/` |
| AU | `/Library/Audio/Plug-Ins/Components/` |

## Maintainer Notes

### Check for updates

```bash
brew livecheck --cask mtrin/audio-plugins/airwindows-consolidated
```

### Manual bump

```bash
# Get latest version
LATEST=$(brew livecheck --cask --json mtrin/audio-plugins/airwindows-consolidated | jq -r '.[0].version.latest')

# Update cask and commit
brew bump-cask-pr --write-only --commit --no-audit --version="$LATEST" mtrin/audio-plugins/airwindows-consolidated

# Push
git -C $(brew --repo mtrin/audio-plugins) push
```

### Automated bumps

Weekly autobump runs via GitHub Actions (`.github/workflows/autobump.yml`).
