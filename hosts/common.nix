{
  config,
  pkgs,
  pkgs-stable,
  zen-browser,
  spicetify-nix,
  ...
}:
{
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    kernelModules = [
      "uinput"
      "v4l2loopback"
    ];
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
  };

  networking.networkmanager.enable = true;

  time.timeZone = "Australia/Sydney";

  i18n = {
    defaultLocale = "en_AU.UTF-8";
    extraLocaleSettings = {
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
  };

  services.xserver = {
    enable = true;
    xkb = {
      layout = "au";
      variant = "";
      options = "caps:escape_shifted_capslock";
    };
  };

  services.displayManager.sddm = {
    enable = false;
    wayland.enable = true;
    extraPackages = with pkgs.kdePackages; [
      qtsvg
      qtmultimedia
      qtvirtualkeyboard
    ];
    theme = "sddm-astronaut-theme";
  };
  services.displayManager.ly.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    extraConfig.pipewire."10-rt-prio" = {
      "context.modules" = [
        {
          name = "libpipewire-module-rt";
          args = {
            "nice.level" = -11;
            "rt.prio" = 88;
          };
          flags = [
            "ifexists"
            "nofail"
          ];
        }
      ];
    };
  };

  hardware = {
    bluetooth.enable = true;
    opentabletdriver.enable = true;
    uinput.enable = true;
  };

  xdg = {
    menus.enable = true;
    mime.enable = true;
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.hyprland.enableGnomeKeyring = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  # security.pam.services.login.kwallet.enable = pkgs.lib.mkForce false;
  # security.pam.services.sddm.kwallet.enable = pkgs.lib.mkForce false;

  programs.seahorse.enable = true;

  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
  };

  services = {
    flatpak.enable = true;
    fwupd.enable = true;
    gvfs.enable = true;
    upower.enable = true;
    printing.enable = true;
    dbus = {
      enable = true;
      packages = [ pkgs.seahorse ];
    };

    power-profiles-daemon.enable = true;

    ollama.enable = true;

    emacs = {
      enable = true;
      package = pkgs.emacs;
    };
  };

  programs = {
    zsh.enable = true;
    neovim.defaultEditor = true;
    dconf.enable = true;
    firefox.enable = false;
    nix-ld.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    virt-manager.enable = true;

    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };

    gamescope.enable = true;
    gamemode.enable = true;

    obs-studio = {
      enable = true;
      package = pkgs.obs-studio.override { cudaSupport = true; };
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vaapi
        obs-gstreamer
        obs-vkcapture
      ];
    };

    spicetify =
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

    nix-ld.libraries = with pkgs; [
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
      wayland
      wayland-protocols
      libxkbcommon
      libX11
      libXrandr
      libXi
      libXcursor
      libXinerama
      libXrender
      libXtst
      freetype
      fontconfig
      yad
      libXxf86vm
    ];
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };

  # environment.sessionVariables = {
  #   C_INCLUDE_PATH      = "${pkgs.glibc.dev}/include";
  #   CPLUS_INCLUDE_PATH  = "${pkgs.gcc.cc}/include/c++/${pkgs.gcc.cc.version}:${pkgs.glibc.dev}/include";
  #   LIBRARY_PATH        = "${pkgs.glibc}/lib:${pkgs.gcc.cc.lib}/lib";
  #   CPATH               = "${pkgs.glibc.dev}/include";
  #   RUST_SRC_PATH       = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  # };

  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    vim
    neovim
    file
    tree
    sops

    ghostty
    zsh
    oh-my-zsh
    tmux

    bat
    eza
    ripgrep
    fd
    fzf
    jq
    zoxide
    zed-editor
    btop
    htop
    fastfetch
    tldr

    mpv
    ffmpeg
    yt-dlp
    imagemagick
    cheese

    libreoffice-qt-fresh
    zathura
    foliate
    texlive.combined.scheme-medium

    zen-browser.packages.${pkgs.system}.beta
    chromium

    vesktop

    kdePackages.dolphin
    nautilus
    gparted
    kdePackages.ark
    unar
    unzip
    p7zip
    rar
    jq
    poppler-utils
    ffmpegthumbnailer

    keepassxc
    trilium-desktop
    rnote

    krita

    osu-lazer-bin
    prismlauncher
    (heroic.override {
      extraPkgs =
        ps: with ps; [
          gamescope
          gamemode
        ];
    })
    protonup-rs
    protontricks

    aider-chat
    ollama
    koboldcpp
    mistral-vibe

    networkmanagerapplet
    inetutils
    dnsmasq
    tor
    tor-browser
    qbittorrent
    catgirl

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
    scanmem
    pince
    volatility3
    gnupg
    age

    qemu
    pkgs-stable.wineWowPackages.stable
    winetricks
    vinegar

    openjdk21
    openjdk17

    cmake
    gnumake
    gcc
    nasm
    clang
    clang-tools
    rustc
    cargo
    pkg-config
    openssl

    lua-language-server
    python3Packages.python-lsp-server
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted

    python3
    python3Packages.pynvim
    nodejs
    nodePackages.npm
    lua
    luajit
    luarocks

    raylib
    libGL
    libGLU
    mesa
    libX11
    libXrandr
    libXi
    libXcursor
    libXinerama
    libXrender
    libXtst
    libXxf86vm
    wayland
    wayland-protocols
    libxkbcommon
    glibc
    glib

    usbutils
    acpi
    inxi
    sysstat
    lm_sensors
    brightnessctl
    pamixer
    iw
    pulseaudio
    pavucontrol
    wl-clipboard
    xclip
    xinput
    libnotify
    libsecret
    pinentry-gnome3
    mission-center
    openrgb-with-all-plugins
    alarm-clock-applet
    termdown
    ani-cli

    kdePackages.kmines
    kdePackages.kolourpaint
    kdePackages.kpat
    kdePackages.kleopatra
    kdePackages.kdenetwork-filesharing
    kdePackages.discover
    ace-of-penguins

    gnome-calendar
    gnome-weather
    epiphany
    gnome-keyring
    seahorse

    (sddm-astronaut.override { embeddedTheme = "hyprland_kath"; })

    man-pages
    man-pages-posix
    mousepad
    vscodium
    emacs
    cmus
    more
    most
    yad
    zenity
    qalculate-qt
    nnn
    feh
    dmenu
    samba
    cifs-utils
    lazygit
    starship
    ispell
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
    nerd-fonts.victor-mono
    nerd-fonts.space-mono
    nerd-fonts.symbols-only
    noto-fonts-cjk-sans
    nerd-fonts._3270
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

  documentation = {
    enable = false;
    man.man-db.enable = false;
    man.mandoc.enable = false;
    dev.enable = false;
  };

  system.stateVersion = "25.05";
}
