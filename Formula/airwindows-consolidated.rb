# Formula/airwin2rack.rb
class AirwindowsConsolidated < Formula
  desc "Airwindows Consolidated macOS DAW Plugin"
  homepage "https://github.com/baconpaul/airwin2rack"
  url "https://github.com/baconpaul/airwin2rack/releases/download/DAWPlugin/airwindows-consolidated-macOS-2025-06-21-5ea9f35.dmg"
  source_type :github
  sha256 "0fbae22d40b590f71fcc50e5c48379ad3b5ea01c8b73669c8f4dab66f4f83c64"

  livecheck do
    url :homepage
    regex(/^DAWPlugin$/i)
  end

  def install
    system "xar", "-xf", "airwindows-consolidated-macOS-2025-06-21-5ea9f35.pkg"

    # Navigate into the extracted VST3 sub-package directory and extract its Payload
    # The Payload is a gzipped cpio archive
    cd "airwindows-consolidated_VST3.pkg" do
      system "tar", "-xf", "Payload"
      # The VST3 plugin is now extracted to the current directory (which is inside the VST3.pkg temp dir)
      # It's located at ./Airwindows Consolidated.vst3
      # We need to copy it to the Homebrew prefix's VST3 directory
      (prefix/"Library/Audio/Plug-Ins/VST3").mkpath
      cp_r "Airwindows Consolidated.vst3", prefix/"Library/Audio/Plug-Ins/VST3"
    end
  end
end
  ## TODO
  # gh api repos/baconpaul/airwin2rack/releases \
  # --jq '.[] | select(.assets != null) | .assets[] | select(.name | test("macOS.*dmg$")) | .browser_download_url' \
  # | head -n1
