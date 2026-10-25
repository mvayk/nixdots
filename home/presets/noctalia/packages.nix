{
  pkgs,
  lib,
  config,
  inputs,
  gslapper,
  ...
}: {
  home.packages = with pkgs; [
    mpvpaper
    gst_all_1.gstreamer
    gslapper.packages.${pkgs.stdenv.hostPlatform.system}.gslapper
  ];
}
