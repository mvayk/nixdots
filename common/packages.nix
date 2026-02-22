{
  config,
  pkgs,
  pkgs-stable,
  zen-browser,
  spicetify-nix,
  firefox-nightly,
  ...
}:
{
  programs.steam = {
    enable = true;

    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  documentation = {
    enable = false;
    man = {
      man-db.enable = false;
      mandoc.enable = false;
    };
    dev = {
      enable = false;
    };
  };

  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };

  programs.dconf.enable = true;
  programs.firefox.enable = false;
  programs.zsh.enable = true;
  # programs.fish.enable = true;
  programs.neovim.defaultEditor = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  programs.obs-studio = {
    enable = true;

    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi
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
    kdePackages.kleopatra
    ace-of-penguins

    qalculate-qt
    trilium-desktop
    gnome-calendar
    gnome-weather
    epiphany
    gparted
    nautilus
    kdePackages.ark
    file

    (pkgs.sddm-astronaut.override {
      embeddedTheme = "hyprland_kath";
    })

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
    volatility3

    aider-chat
    mousepad
    dnsmasq
    inetutils

    ollama
    koboldcpp
    tldr
    openrgb-with-all-plugins
    libsecret
    pinentry-gnome3

    mission-center

    gnupg
    cmake
    gnumake
    pkgs-stable.wineWowPackages.stable
    winetricks
    libreoffice-qt-fresh
    ffmpegthumbnailer
    unar
    jq
    poppler-utils
    unzip
    apple-cursor
    rar
    chromium
    p7zip
    raylib
    gcc
    nasm
    # firefox-beta
    # firefox-nightly.packages.${system}.firefox-nightly-bin
    glibc
    glib
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
    # linux-manual # why does kernel 6.19 cause problems with api man pages?
    man-pages
    man-pages-posix
    qemu
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
    krita
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
    usbutils
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
      extraPkgs =
        pkgs: with pkgs; [
          gamescope
          gamemode
        ];
    })
    kdePackages.kdenetwork-filesharing
    samba

    cifs-utils
    lua-language-server
    rustc
    mistral-vibe
    clang
    clang-tools
    python3Packages.python-lsp-server
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
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
    libX11
    libXrandr
    libXi
    libXcursor
    libXinerama
    libXrender
    libXtst
    libXi

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
    nerd-fonts._3270
  ];

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
    libX11
    libXrandr
    libXi
    libXcursor
    libXinerama
    libXrender
    libXtst
    libXi
    freetype
    fontconfig
  ];
}
