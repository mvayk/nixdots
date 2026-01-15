{ config, pkgs, ... }:
let
    nixDir = ./nix;
    getNixFiles = dir:
    if builtins.pathExists dir then
    let
        files = builtins.attrNames (builtins.readDir dir);
        isNixFile = name: builtins.match ".*\.nix$" name != null;
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
    home.packages = with pkgs; [
        qt6Packages.qt6ct
        libsForQt5.qt5ct
        lxappearance
        xclip
        xfce4-pulseaudio-plugin
        xfce4-whiskermenu-plugin
    ];
}

