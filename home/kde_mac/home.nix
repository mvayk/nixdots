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
        ../../common/zshrc.nix
    ];
    home.username = "mvayk";
    home.homeDirectory = "/home/mvayk";
    home.stateVersion = "25.05";
    home.file = {
        ".config" = {
            source = ./mvayk/.config;
            recursive = true;
        };
        ".tmux.conf".source = ./mvayk/.tmux.conf;
    };
    programs.plasma = {
        enable = true;
    };
    programs.git = {
        enable = true;
        userName = "mvayk";
        userEmail = "mvayk@mvayk.mvayk";
    };
    

    home.packages = with pkgs; [
        kdePackages.full
        qt6ct
        libsForQt5.qt5ct
        grim
        slurp
        rofi
        wl-clipboard
    ];
}
