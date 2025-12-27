# Audio Plugins

Homebrew tap for macOS audio plugins (VST3).

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

- **airwindows-consolidated** - [Airwindows Consolidated](https://github.com/baconpaul/airwin2rack) DAW plugin

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
