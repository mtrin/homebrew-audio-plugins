# Formula/airwin2rack.rb
class AirwindowsConsolidated < Formula
  desc "Airwindows Consolidated macOS DAW Plugin"
  homepage "https://github.com/baconpaul/airwin2rack"
  url "https://github.com/baconpaul/airwin2rack/releases/download/DAWPlugin/airwindows-consolidated-macOS-2025-06-21-5ea9f35.dmg"
  sha256 "0fbae22d40b590f71fcc50e5c48379ad3b5ea01c8b73669c8f4dab66f4f83c64"

  livecheck do
    url :homepage
    regex(/^DAWPlugin$/i) # Adjust this regex if the release tag format changes
  end

  def install
    # Extract the .pkg file from the mounted .dmg
    # The .dmg is automatically mounted by Homebrew.
    # The .pkg file is usually in the root of the mounted DMG.
    # Use `xar` to extract the contents of the .pkg
    system "xar", "-xf", "airwindows-consolidated-macOS-2025-06-21-5ea9f35.pkg"

    # The VST3 plugin is typically located within the extracted package.
    # We need to find the .vst3 bundle and copy it to the correct location.
    # Assuming the VST3 is directly in the extracted payload or a common subdirectory.
    # Common path for VST3 plugins is /Library/Audio/Plug-Ins/VST3/
    # Homebrew installs to prefix, so we'll copy to prefix/"Library/Audio/Plug-Ins/VST3"
    # and then symlink if necessary, but usually Homebrew handles the final location.

    # Find the VST3 bundle within the extracted contents.
    # This path might need adjustment based on the actual pkg structure.
    vst3_plugin_path = "Airwindows.vst3" # This is a common name, might need to be more specific

    # Copy the VST3 plugin to the Homebrew prefix's VST3 directory
    # Ensure the target directory exists
    (lib/"vst3").mkpath
    cp_r vst3_plugin_path, lib/"vst3"
  end
end
