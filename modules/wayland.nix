{
  pkgs,
  lib,
  ...
}: {
  programs.ydotool.enable = true;

  environment.systemPackages = with pkgs; [
    wl-clipboard
    kdePackages.dolphin
    libinput
    kdotool
  ];
}
