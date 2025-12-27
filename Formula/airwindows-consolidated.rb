class AirwindowsConsolidated < Formula
  desc "Airwindows Consolidated macOS DAW Plugin"
  homepage "https://github.com/baconpaul/airwin2rack"
  url "https://github.com/baconpaul/airwin2rack/releases/download/DAWPlugin/airwindows-consolidated-macOS-2025-06-21-5ea9f35.dmg"
  version "2025-06-21-5ea9f35"
  sha256 "0fbae22d40b590f71fcc50e5c48379ad3b5ea01c8b73669c8f4dab66f4f83c64"

  livecheck do
    url :homepage
    regex(/macOS[._-](\d{4}-\d{2}-\d{2}-\h+)/i)
    strategy :github_releases do |json, regex|
      json.filter_map do |release|
        next if release["draft"] || release["prerelease"]
        release["assets"]&.filter_map { |a| a["name"]&.[](regex, 1) }
      end.flatten
    end
  end

  def install
    pkg = Dir["*.pkg"].first
    system "xar", "-xf", pkg

    cd "airwindows-consolidated_VST3.pkg" do
      system "tar", "-xf", "Payload"
      (prefix/"Library/Audio/Plug-Ins/VST3").mkpath
      cp_r "Airwindows Consolidated.vst3", prefix/"Library/Audio/Plug-Ins/VST3"
    end
  end
end
