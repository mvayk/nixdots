{ pkgs, system ? null, zen-browser ? null, firefox-nightly ? null }:

let
  basePackages = with pkgs; [
    # Core utilities
    git
    curl
    vim
    neovim
    wget
    xclip
    btop
    zsh
    tree
    htop
    coreutils
    ripgrep
    fd
    tmux
    direnv
    
    # Security & encryption
    keepassxc
    kdePackages.kleopatra
    libsecret
    pinentry-gnome3
    gnupg
    gnome-keyring
    seahorse
    
    # Network management
    networkmanagerapplet
    iw
    
    # Development tools
    cmake
    gnumake
    gcc
    nasm
    glibc
    glibc.dev
    gdb
    clang
    clang-tools
    pkg-config
    openssl
    
    # Language servers
    lua-language-server
    rust-analyzer
    python3Packages.python-lsp-server
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    
    # Programming languages & runtimes
    openjdk21
    openjdk17
    openjdk8
    jdk8
    python3
    python3Packages.pynvim
    nodejs
    nodePackages.npm
    luarocks
    luajit
    lua
    cargo
    
    # Graphics libraries
    raylib
    libGL
    libGLU
    mesa
    xorg.libXxf86vm
    xorg.libX11
    xorg.libXrandr
    xorg.libXi
    xorg.libXcursor
    xorg.libXinerama
    xorg.libXrender
    xorg.libXtst
    freetype
    fontconfig
    imagemagick
    
    # Wayland
    wayland
    wayland-protocols
    libxkbcommon
    
    # Browsers
    firefox
    firefox-beta
    epiphany
    ungoogled-chromium
    qutebrowser
    tor-browser
    
    # File managers
    kdePackages.dolphin
    nemo
    nnn
    
    # Terminals
    alacritty
    kitty
    
    # Media players
    mpv
    cmus
    
    # Image viewers
    feh
    
    # Document viewers
    zathura
    
    # Text editors
    emacs
    
    # Communication
    vesktop
    
    # Utilities
    kdePackages.kmines
    qalculate-qt
    kdePackages.ark
    ollama
    openrgb-with-all-plugins
    wine
    unzip
    rar
    p7zip
    qbittorrent
    termdown
    ani-cli
    scanmem
    yt-dlp
    eza
    fastfetch
    cheese
    blanket
    libnotify
    texlive.combined.scheme-medium
    obsidian
    flameshot
    tor
    ffmpeg
    dmenu
    xorg.xinput
    acpi
    sysstat
    lm_sensors
    brightnessctl
    pamixer
    alarm-clock-applet
    pavucontrol
    pulseaudio
    
    # Gaming
    steam
    prismlauncher
    
    # File sharing
    kdePackages.kdenetwork-filesharing
    samba
    cifs-utils
    
    # XFCE plugins
    xfce.xfce4-pulseaudio-plugin
    xfce.xfce4-whiskermenu-plugin
  ];

  # nix-ld libraries
  ldLibraries = with pkgs; [
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

  # Optional packages that depend on flake inputs
  flakePackages = [
    zen-browser.packages."${system}".beta
    firefox-nightly.packages.${system}.firefox-nightly-bin
  ];

in
{
  systemPackages = basePackages ++ flakePackages;
  ldLibraries = ldLibraries;
}
