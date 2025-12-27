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
brew bump --open-pr mtrin/audio-plugins/airwindows-consolidated
```

This will:
1. Detect new version via livecheck
2. Download new release and calculate SHA256
3. Update formula and create PR

### Automated bumps

Weekly autobump runs via GitHub Actions (`.github/workflows/autobump.yml`).
