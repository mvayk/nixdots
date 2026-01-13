{ config, pkgs, zen-browser, spicetify-nix, firefox-nightly, ... }:

{
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.networkmanager.enable = true;
    hardware.bluetooth.enable = true;
    services.power-profiles-daemon.enable = true;
    services.ollama = {
        enable = true;
    };

    programs.gnupg.agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-gnome3;
    };

    time.timeZone = "Australia/Sydney";

    i18n.defaultLocale = "en_AU.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_AU.UTF-8";
        LC_IDENTIFICATION = "en_AU.UTF-8";
        LC_MEASUREMENT = "en_AU.UTF-8";
        LC_MONETARY = "en_AU.UTF-8";
        LC_NAME = "en_AU.UTF-8";
        LC_NUMERIC = "en_AU.UTF-8";
        LC_PAPER = "en_AU.UTF-8";
        LC_TELEPHONE = "en_AU.UTF-8";
        LC_TIME = "en_AU.UTF-8";
    };

    services.xserver = {
        xkb = {
            layout = "au";
            variant = "";
        };

        desktopManager = {
            xfce.enable = false;
        };

    };
    services.displayManager.defaultSession = "xfce";

    environment.sessionVariables = {
        C_INCLUDE_PATH = "${pkgs.glibc.dev}/include";
        CPLUS_INCLUDE_PATH = "${pkgs.gcc.cc}/include/c++/${pkgs.gcc.cc.version}:${pkgs.glibc.dev}/include";
        LIBRARY_PATH = "${pkgs.glibc}/lib:${pkgs.gcc.cc.lib}/lib";
        CPATH = "${pkgs.glibc.dev}/include";
    };

    services.flatpak.enable = true;
    services.fwupd.enable = true;

    xdg.mime = {
        enable = true;
        defaultApplications = {
            "image/png" = "feh.desktop";
            "image/jpeg" = "feh.desktop";
            "image/jpg" = "feh.desktop";
            "image/gif" = "feh.desktop";
            "image/webp" = "feh.desktop";
            "image/bmp" = "feh.desktop";

            "video/mp4" = "mpv.desktop";
            "video/x-matroska" = "mpv.desktop";
            "video/webm" = "mpv.desktop";
            "video/avi" = "mpv.desktop";
            "video/x-msvideo" = "mpv.desktop";
            "video/quicktime" = "mpv.desktop";

            "text/plain" = "emacs.desktop";
            "text/x-csrc" = "emacs.desktop";
            "text/x-c++src" = "emacs.desktop";
            "text/x-python" = "emacs.desktop";
            "text/markdown" = "emacs.desktop";
            "application/x-shellscript" = "emacs.desktop";
        };
    };

    services.printing.enable = true;
    services.xserver = {
        enable = true;	
        windowManager.i3.enable = false;
    };

    services.displayManager.ly.enable = true;

    services.emacs = {
        enable = true;
        package = pkgs.emacs;
    };

    programs.hyprland = {
        enable = true;
        #withUWSM = true;
        xwayland.enable = true;
    };

    services.upower.enable = true;

    services.desktopManager.plasma6.enable = true;

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    
    # GNOME Keyring configuration for Dolphin SMB authentication
    services.gnome.gnome-keyring.enable = false;
    security.pam.services.login.enableGnomeKeyring = false;
    security.pam.services.hyprland.enableGnomeKeyring = true;
    programs.seahorse.enable = false;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      
      extraConfig.pipewire = {
        "10-rt-prio" = {
          "context.modules" = [
            {
              name = "libpipewire-module-rt";
              args = {
                "nice.level" = -11;
                "rt.prio" = 88;
              };
              flags = [ "ifexists" "nofail" ];
            }
          ];
        };
      };
    };
    users.users.mvayk = {
        isNormalUser = true;
        description = "John";
        shell = pkgs.zsh;
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
        ];
    };

    documentation = {
        enable = true;
        man = {
            man-db.enable = false;
            mandoc.enable = true;
        };
        dev = {
            enable = true;
        };
    };

    programs.dconf.enable = true;
    programs.firefox.enable = true;
    programs.zsh.enable = true;
    # programs.fish.enable = true;
    programs.neovim.defaultEditor = true;
    nixpkgs.config.allowUnfree = true;
    programs.thunar.enable = true;
    programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
    };

    xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
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
            shuffle # shuffle+ (special characters are sanitized out of extension names)
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
        qalculate-qt
        trilium-desktop
        epiphany
        kdePackages.ark
        ollama
        openrgb-with-all-plugins
        kdePackages.kleopatra
        libsecret
        pinentry-gnome3
        gnupg
        cmake
        gnumake
        wine
        libreoffice-qt-fresh
        unzip
        rar
        p7zip
        gcc
        nasm
        firefox-beta
        firefox-nightly.packages.${system}.firefox-nightly-bin
        glibc
        tree
        steam
        zsh
        lazygit
        qbittorrent
        termdown
        ani-cli
        kdePackages.discover
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
        cmus
        ungoogled-chromium
        scanmem
        htop
        gdb
        yt-dlp
        firefox
        gimp
        starship
        eza
        gnome-keyring
        seahorse
        fastfetch
        cheese
        mpv
        prismlauncher
        blanket
        emacs
        libnotify
        tmux
        texlive.combined.scheme-medium
        imagemagick
        obsidian
        flameshot
        tor
        tor-browser
        vesktop
        qutebrowser
        pulseaudio
        kdePackages.dolphin
        nemo
        ffmpeg
        nnn
        zathura
        foliate
        feh
        dmenu
        cargo
        ispell
        xorg.xinput
        acpi
        sysstat
        lm_sensors
        brightnessctl
        pamixer
        iw
        alarm-clock-applet
        coreutils
        pavucontrol
	alacritty
        kitty
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
        nerd-fonts.space-mono
        nerd-fonts.symbols-only
        noto-fonts-cjk-sans
    ];

    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      stdenv.cc.cc.lib
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

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    services.gvfs.enable = true;
    #services.openssh.enable = true;
    system.stateVersion = "25.05";
}
