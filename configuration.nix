{ config, pkgs, zen-browser, spicetify-nix, ... }:

{
    imports =
    [
        ./hardware-configuration.nix
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos";

    networking.networkmanager.enable = true;
    hardware.bluetooth.enable = true;
    services.power-profiles-daemon.enable = true;
    services.ollama = {
        enable = true;
    };

    programs.gnupg.agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-gnome3;  # or pkgs.pinentry-curses
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

    services.printing.enable = true;
    services.xserver = {
        enable = true;	
        windowManager.i3.enable = false;
    };

    services.displayManager.ly.enable = true;
    services.syncthing = {
        enable = true;
        openDefaultPorts = true;
    };

    services.emacs = {
        enable = true;
        package = pkgs.emacs;
    };

    programs.hyprland = {
        enable = false;
        #withUWSM = true;
        xwayland.enable = true;
    };

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
            intel-media-driver
            intel-vaapi-driver
            libvdpau-va-gl
        ];
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

    programs.dconf.enable = true;
    programs.firefox.enable = true;
    programs.zsh.enable = true;
    programs.neovim.defaultEditor = true;
    nixpkgs.config.allowUnfree = true;

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
        epiphany
        kdePackages.ark
        ollama
        kdePackages.kleopatra
        libsecret
        pinentry-gnome3
        gnupg
        cmake
        gnumake
        wine
        unzip
        rar
        p7zip
        gcc
        nasm
        glibc
        steam
        zsh
        qbittorrent
        termdown
        ani-cli
        zen-browser.packages."${system}".beta
        openjdk21
        openjdk17
        openjdk8
        jdk8
        oh-my-zsh
        cmus
        ungoogled-chromium
        scanmem
        htop
        gdb
        yt-dlp
        firefox
        eza
        gnome-keyring
        seahorse
        fastfetch
        cheese
        mpv
        prismlauncher
        brave
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
        pavucontrol
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

        xfce.xfce4-pulseaudio-plugin  # Adds the plugin binary and XFCE integration
        xfce.xfce4-whiskermenu-plugin  # Adds the plugin binary and XFCE integration
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
