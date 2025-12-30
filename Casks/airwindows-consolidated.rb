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

  vst3_plugin "Airwindows Consolidated.vst3",
              target: "/Library/Audio/Plug-Ins/VST3/Airwindows Consolidated.vst3"

  artifact "airwindows", target: "/Library/Audio/Plug-Ins/VST/airwindows"

  preflight do
    # Extract VST3 from consolidated pkg
    system_command "/usr/bin/xar",
                   args: ["-xf", "#{staged_path}/airwindows-consolidated-macOS-#{version}.pkg",
                          "-C", staged_path]
    system_command "/usr/bin/tar",
                   args: ["-xf", "#{staged_path}/airwindows-consolidated_VST3.pkg/Payload",
                          "-C", staged_path]

    # Download VST2 DMG
    system_command "/usr/bin/curl",
                   args: ["-L", "-o", "#{staged_path}/SignedMacVSTs.dmg",
                          "https://www.airwindows.com/wp-content/uploads/SignedMacVSTs.dmg"]

    # Mount, copy, unmount with ensure for cleanup
    vst2_mount = staged_path/"vst2_mount"
    FileUtils.mkdir_p(vst2_mount)
    begin
      system_command "/usr/bin/hdiutil",
                     args: ["attach", "#{staged_path}/SignedMacVSTs.dmg",
                            "-nobrowse", "-readonly", "-noverify",
                            "-mountpoint", vst2_mount]

      # Create airwindows folder and copy contents
      FileUtils.mkdir_p("#{staged_path}/airwindows")
      FileUtils.cp_r(Dir["#{vst2_mount}/*.vst"], "#{staged_path}/airwindows/")
      FileUtils.cp_r(Dir["#{vst2_mount}/*.txt"], "#{staged_path}/airwindows/")
    ensure
      system_command "/usr/bin/hdiutil", args: ["detach", vst2_mount], must_succeed: false
    end
  end

  uninstall delete: [
    "/Library/Audio/Plug-Ins/VST3/Airwindows Consolidated.vst3",
    "/Library/Audio/Plug-Ins/VST/airwindows",
  ]
end
