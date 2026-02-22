{ config, pkgs, ... }:
let
  nixDir = ./nix;
  getNixFiles =
    dir:
    if builtins.pathExists dir then
      let
        files = builtins.attrNames (builtins.readDir dir);
        isNixFile = name: builtins.match ".*\.nix$" name != null;
        nixFiles = builtins.filter isNixFile files;
      in
      map (name: "${dir}/${name}") nixFiles
    else
      [ ];
in
{
  imports = getNixFiles nixDir ++ [
    ../../common/shared-home.nix
    ./nix/dunst.nix
    ./nix/i3.nix
  ];
  home.file = {
    ".config" = {
      source = ./. + "/${config.home.username}/.config";
      recursive = true;
    };
  };
  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    x11 = {
      enable = true;
    };
  };
  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };
  home.packages = with pkgs; [
    tokyonight-gtk-theme
    qt6Packages.qt6ct
    libsForQt5.qt5ct
    lxappearance
    bibata-cursors
    papirus-icon-theme
    i3
    i3lock
    i3status
    dmenu
    i3blocks
    polybar
  ];
}
