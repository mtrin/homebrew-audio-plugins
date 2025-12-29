cask "airwindows-consolidated" do
  version "2025-12-20-458cc00"
  sha256 "1459a556d07361cfdbd664a62928af19cf749e2232e6437c8b463eb1a48abbf2"

  url "https://github.com/baconpaul/airwin2rack/releases/download/DAWPlugin/airwindows-consolidated-macOS-#{version}.dmg"
  name "Airwindows Consolidated"
  desc "Consolidated DAW plugin for Chris's Airwindows effects"
  homepage "https://github.com/baconpaul/airwin2rack"

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

  preflight do
    system_command "/usr/bin/xar",
                   args: ["-xf", "#{staged_path}/airwindows-consolidated-macOS-#{version}.pkg",
                          "-C", staged_path]
    system_command "/usr/bin/tar",
                   args: ["-xf", "#{staged_path}/airwindows-consolidated_VST3.pkg/Payload",
                          "-C", staged_path]
  end

  vst3_plugin "Airwindows Consolidated.vst3",
              target: "/Library/Audio/Plug-Ins/VST3/Airwindows Consolidated.vst3"

  uninstall delete: "/Library/Audio/Plug-Ins/VST3/Airwindows Consolidated.vst3"
end
