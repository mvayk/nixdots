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
    programs.git = {
        enable = true;
        userName = "mvayk";
        userEmail = "mvayk@mvayk.mvayk";
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
    services.swaync = {
        enable = true;
    };
    home.packages = with pkgs; [
        qt6ct
        libsForQt5.qt5ct
        lxappearance
        bibata-cursors
        papirus-icon-theme
        hyprland
        waybar
        swww
        grim
        slurp
        rofi
        wl-clipboard
        hyprlock
        hypridle
    ];
}
