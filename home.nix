{ config, pkgs, ... }:

let
    nixDir = ./home/nix;

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
    imports = getNixFiles nixDir;

    home.username = "mvayk";
    home.homeDirectory = "/home/mvayk";
    home.stateVersion = "25.05";

    home.file = {
        ".config" = {
            source = ./home/mvayk/.config;
            recursive = true;
        };
        ".tmux.conf".source = ./home/mvayk/.tmux.conf;
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

    home.packages = with pkgs; [
        tokyo-night-gtk
        qt6ct
        libsForQt5.qt5ct
        lxappearance
        bibata-cursors
        papirus-icon-theme
        zsh
        oh-my-zsh
        cmus
        yt-dlp
        eza
        fastfetch
        neovim
        mpv
        emacs
        tmux
        texlive.combined.scheme-medium  # or scheme-full if you want everything
        imagemagick   # alternative renderer
        obsidian
        flameshot
        tor
        tor-browser
        vesktop
        qutebrowser
        kdePackages.dolphin
        ffmpeg
        nnn
        i3-gaps
        i3lock
        i3status
        zathura
        feh
        dmenu
        cargo
        xorg.xinput
        acpi
        sysstat
        lm_sensors
        brightnessctl
        pamixer
        iw
        alarm-clock-applet
        coreutils
        i3blocks
        pavucontrol
        kitty
    ];
}
