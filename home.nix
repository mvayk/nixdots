{ config, pkgs, ... }:

{
    imports = let
        homeDir = ./home;
        isNixFile = name: builtins.match ".*\.nix$" name != null;
        nixFiles = builtins.filter isNixFile (builtins.attrNames (builtins.readDir homeDir));
    in
    map (name: "${homeDir}/${name}") nixFiles;

    home.username = "mvayk";
    home.homeDirectory = "/home/mvayk";
    programs.git.enable = true;
    home.stateVersion = "25.05";

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
        tokyo-night-gtk

        qt6ct
        libsForQt5.qt5ct

        lxappearance

        bibata-cursors
        papirus-icon-theme

        zsh
        oh-my-zsh
        eza
        fastfetch
        neovim
        emacs
        tmux
        flameshot
        vesktop
        kdePackages.dolphin
        yazi
        tmux
        polybar
        i3-gaps
        i3lock
        zathura
        feh
        dmenu
        fastfetch
    ];
}
