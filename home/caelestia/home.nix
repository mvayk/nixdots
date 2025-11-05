{ config, pkgs, quickshell, caelestia-shell, caelestia-cli, ... }:
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
        settings = {
            user = {
                userName = "mvayk";
                userEmail = "mvayk@mvayk.mvayk";
            };
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
        QT_QUICK_BACKEND = "software";
    };

    gtk = {
        enable = true;
        iconTheme = {
            name = "WhiteSur-dark";
            package = pkgs.whitesur-icon-theme;
        };
        theme = {
            name = "WhiteSur-Dark";
            package = pkgs.whitesur-gtk-theme;
        };
    };

    qt = {
        enable = true;
        platformTheme.name = "gtk3";  # Use GTK theme for Qt apps
        style.name = "adwaita-dark";
    };
    home.packages = with pkgs; [
        qt6Packages.qt6ct
        libsForQt5.qt5ct
        whitesur-icon-theme
        whitesur-gtk-theme
        lxappearance
        bibata-cursors
        hyprland
        grim
        slurp
        wl-clipboard
        hyprlock
        hypridle
        nwg-look
        quickshell
        caelestia-shell.packages.${system}.default
    ];
}
