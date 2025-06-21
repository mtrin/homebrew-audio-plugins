# Formula/airwin2rack.rb
class Airwin2rack < Formula
  desc "Airwindows Consolidated macOS DAW Plugin"
  homepage "https://github.com/baconpaul/airwin2rack"
  url "https://github.com/baconpaul/airwin2rack/releases/download/DAWPlugin/airwindows-consolidated-macOS-2025-06-21-5ea9f35.dmg"
  sha256 "0fbae22d40b590f71fcc50e5c48379ad3b5ea01c8b73669c8f4dab66f4f83c64"

  livecheck do
    url :homepage
    regex(/^DAWPlugin$/i) # Adjust this regex if the release tag format changes
  end

  pkg "airwindows-consolidated-macOS-2025-06-21-5ea9f35.pkg"

  def install
  end
end
