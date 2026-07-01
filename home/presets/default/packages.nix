{pkgs, ...}: {
  home.packages = with pkgs; [
    wallust
    waybar
    rofi
  ];
}
