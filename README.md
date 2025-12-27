# Audio Plugins

Homebrew tap for macOS audio plugins (VST3, AU).

## Install

```bash
brew tap mtrin/audio-plugins
brew install airwindows-consolidated
```

## Update

```bash
brew update
brew upgrade airwindows-consolidated
```

## Available Formulas

- **airwindows-consolidated** - [Airwindows Consolidated](https://github.com/baconpaul/airwin2rack) DAW plugin

## Maintainer Notes

### Check for updates

```bash
brew livecheck mtrin/audio-plugins/airwindows-consolidated
```

### Manual bump

```bash
# Get latest version
LATEST=$(brew livecheck --json mtrin/audio-plugins/airwindows-consolidated | jq -r '.[0].version.latest')

# Update formula and commit
brew bump-formula-pr --write-only --commit --no-audit --version="$LATEST" mtrin/audio-plugins/airwindows-consolidated

# Push
git -C $(brew --repo mtrin/audio-plugins) push
```

### Automated bumps

Weekly autobump runs via GitHub Actions (`.github/workflows/autobump.yml`).
