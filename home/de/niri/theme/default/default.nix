{
  pkgs,
  lib,
  ...
}: let
  dir = ../../../../presets/default;
  fileNames = builtins.attrNames (builtins.readDir dir);
  nixFiles = builtins.filter (n: lib.hasSuffix ".nix" n && n != "default.nix") fileNames;
in {
  imports =
    map (n: dir + "/${n}") nixFiles
    ++ [];
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };
  programs.niri = {
    settings = {
      environment = {
        XCURSOR_THEME = "Bibata-Modern-Classic";
        XCURSOR_SIZE = "24";
      };
      cursor = {
        theme = "Bibata-Modern-Classic";
        size = 24;
      };
    };
  };
}
