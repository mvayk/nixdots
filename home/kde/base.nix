{ config, pkgs, ... }:
let
  nixDir = ./nix;
  getNixFiles = dir:
    if builtins.pathExists dir then
      let
        files = builtins.attrNames (builtins.readDir dir);
        isNixFile = name: builtins.match ".*\\.nix$" name != null;
        nixFiles = builtins.filter isNixFile files;
      in
        map (name: "${dir}/${name}") nixFiles
    else [];
in
{
  imports = getNixFiles nixDir ++ [
        ../../common/shared-home.nix
  ];

  home.file = {
    ".config" = {
      source = ./mvayk/.config;
      recursive = true;
    };
  };
}
