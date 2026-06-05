{
  pkgs,
  lib,
  mshell,
  ...
}:
let
  dir = ../../../../presets/default;
  fileNames = builtins.attrNames (builtins.readDir dir);
  nixFiles = builtins.filter (n: lib.hasSuffix ".nix" n && n != "default.nix") fileNames;
in
{
  imports = map (n: dir + "/${n}") nixFiles ++ [ ];

  programs.niri = {
    package = pkgs.niri;
    settings = {
      spawn-at-startup = [
        {
          command = [
            "qs"
          ];
        }
        {
          command = [
            "nm-applet"
          ];
        }
        {
          command = [
            "xwayland-satellite"
          ];
        }
      ];
    };
  };

  home.packages = [
    mshell.packages.${pkgs.system}.default
  ];
}
