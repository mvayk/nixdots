{
  pkgs,
  lib,
  ...
}: {
  programs.ydotool.enable = true;

  environment.systemPackages = with pkgs; [
    wl-clipboard
    swayimg
    kdePackages.dolphin
    libinput
    kdotool
  ];
}
