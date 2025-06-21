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
    # Extract the main .pkg file from the mounted .dmg
    # This will create directories like airwindows-consolidated_VST3.pkg, etc.
    system "xar", "-xf", "airwindows-consolidated-macOS-2025-06-21-5ea9f35.pkg"

    # Navigate into the extracted VST3 sub-package directory
    # Extract the Payload from the VST3 sub-package
    # The Payload is a gzipped cpio archive
    cd "airwindows-consolidated_VST3.pkg" do
      system "tar", "-xf", "Payload"
    end

    # The VST3 plugin should now be extracted to the current directory (which is the buildpath)
    # It's typically found in ./Library/Audio/Plug-Ins/VST3/
    # Ensure the target directory exists within Homebrew's prefix
    (prefix/"Library/Audio/Plug-Ins/VST3").mkpath

    # Copy the VST3 plugin bundle
    # The VST3 bundle will be in the current directory (buildpath) after extracting Payload
    # The path will be something like ./Library/Audio/Plug-Ins/VST3/Airwindows.vst3
    cp_r "Library/Audio/Plug-Ins/VST3/Airwindows.vst3", prefix/"Library/Audio/Plug-Ins/VST3"
  end
end
