{ config, pkgs, zen-browser, spicetify-nix, firefox-nightly, ... }:
{


programs.steam = {
    enable = true;

    extraCompatPackages = with pkgs; [
        proton-ge-bin
    ];
};

 programs.obs-studio = {
    enable = true;

    # optional Nvidia hardware acceleration
    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi #optional AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
    ];
  };
    programs.spicetify =
    let
        spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
        enable = true;
        enabledExtensions = with spicePkgs.extensions; [
            adblock
            hidePodcasts
            shuffle
        ];
        enabledCustomApps = with spicePkgs.apps; [
            newReleases
            ncsVisualizer
        ];
        enabledSnippets = with spicePkgs.snippets; [
            rotatingCoverart
            pointer
        ];
    };
    environment.systemPackages = with pkgs; [
        git
        curl
        vim
        neovim
        wget
        keepassxc
        networkmanagerapplet
        xclip
        btop
        zsh
        kdePackages.kmines
        kdePackages.kolourpaint
        kdePackages.kpat
        ace-of-penguins
        qalculate-qt
        trilium-desktop
        epiphany
        kdePackages.ark

        ghidra
        radare2
        binaryninja-free
        cutter
        rizin
        gdb
        gef
        strace
        ltrace
        binwalk
        imhex
        hexdump
        scanmem
        pince

        aider-chat
        mousepad

        ollama
        koboldcpp
        tldr
        openrgb-with-all-plugins
        kdePackages.kleopatra
        libsecret
        pinentry-gnome3

        mission-center

        gnupg
        cmake
        gnumake
        wine
        libreoffice-qt-fresh
        ffmpegthumbnailer
        unar
        jq
        poppler-utils
        unzip
        apple-cursor
        rar
        p7zip
        raylib
        gcc
        nasm
        # firefox-beta
        # firefox-nightly.packages.${system}.firefox-nightly-bin
        glibc
        tree
        steam
        protontricks
        protonup-rs
        zsh
        lazygit
        qbittorrent
        termdown
        ani-cli
        kdePackages.discover
        vinegar
        flatpak
        zen-browser.packages."${system}".beta
        openjdk21
        openjdk17
        openjdk8
        jdk8
        linux-manual
        man-pages
        man-pages-posix
        oh-my-zsh
        catgirl
        cmus
        more
        bat
        most
        scanmem
        htop
        gdb
        rnote
        yt-dlp
        # firefox
        gimp
        zed-editor
        starship
        eza
        gnome-keyring
        seahorse
        fastfetch
        cheese
        mpv
        prismlauncher
        emacs
        libnotify
        tmux
        texlive.combined.scheme-medium
        imagemagick
        bat
        flameshot
        tor
        fzf
        zoxide
        tor-browser
        vesktop
        #qutebrowser
        pulseaudio
        yad
        kdePackages.dolphin
        # env SDL_VIDEODRIVER=wayland osu-lazer
        osu-lazer-bin
        opentabletdriver
        ffmpeg
        nnn
        zathura
        foliate
        feh
        dmenu
        vscodium
        catgirl
        cargo
        ispell
        xorg.xinput
        acpi
        inxi
        sysstat
        lm_sensors
        brightnessctl
        pamixer
        iw
        alarm-clock-applet
        coreutils
        pavucontrol
        alacritty
        zenity
        ghostty
        (heroic.override {
         extraPkgs = pkgs: with pkgs; [
         gamescope
         gamemode
         ];
         })
        kdePackages.kdenetwork-filesharing
        samba

        cifs-utils
        lua-language-server
        clang
        clang-tools  # includes clangd
        rust-analyzer
        python3Packages.python-lsp-server
        nodePackages.typescript-language-server
        nodePackages.vscode-langservers-extracted  # includes html, css, json, eslint
      raylib
      libGL
      libGLU
      mesa
      xorg.libXxf86vm
      wayland
      wayland-protocols
      libxkbcommon
      libGL
      libGLU
      xorg.libX11
      xorg.libXrandr
      xorg.libXi
      xorg.libXcursor
      xorg.libXinerama
      xorg.libXrender
      xorg.libXtst
      xorg.libXi

        pkg-config
        openssl
        ripgrep
        fd
        python3
        python3Packages.pynvim
        nodejs
        nodePackages.npm
        luarocks
        luajit
        lua
    ];

    fonts.packages = with pkgs; [
        nerd-fonts.iosevka
        nerd-fonts.jetbrains-mono
        nerd-fonts.victor-mono
        nerd-fonts.space-mono
        nerd-fonts.symbols-only
        noto-fonts-cjk-sans
    ];

    programs.gamescope.enable = true;
    programs.gamemode.enable = true;

    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      stdenv.cc.cc.lib
      yad
      zlib
      openssl
      glibc
      glibc.dev
      libgcc
      libgit2
      pkg-config
      curl
      raylib
      libGL
      libGLU
      mesa
      xorg.libXxf86vm
      wayland
      wayland-protocols
      libxkbcommon
      libGL
      libGLU
      xorg.libX11
      xorg.libXrandr
      xorg.libXi
      xorg.libXcursor
      xorg.libXinerama
      xorg.libXrender
      xorg.libXtst
      xorg.libXi
      freetype
      fontconfig
    ];
}
