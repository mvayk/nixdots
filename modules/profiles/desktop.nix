{
  pkgs,
  lib,
  config,
  mkSub,
  zen-browser,
  helium,
  spicetify-nix,
  firefox-nightly,
  ...
}: let
  cfg = config.my.desktop;
  system = pkgs.stdenv.hostPlatform.system;
in {
  options.my.desktop = {
    enable = lib.mkEnableOption "desktop apps";

    browsers.enable = mkSub cfg.enable "web browsers";
    kde.enable = mkSub cfg.enable "KDE apps (dolphin, ark, ...)";
    privacy.enable = mkSub cfg.enable "keyrings, gpg agent, keepassxc, tor";
    utils.enable = mkSub cfg.enable "terminal, X11 helpers, audio/network applets";
    apps.enable = mkSub cfg.enable "general GUI apps";
    obs.enable = mkSub cfg.enable "OBS Studio";
    obs.cuda = lib.mkEnableOption "CUDA-enabled OBS";
    spotify.enable = mkSub cfg.enable "Spotify + spicetify";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      my.fonts.enable = lib.mkDefault true;
    })

    (lib.mkIf cfg.browsers.enable {
      #programs.firefox.enable = true;
      environment.systemPackages = [
        zen-browser.packages.${system}.beta
        #firefox-nightly.packages.${system}.firefox-nightly-bin
        helium.packages.${system}.default
        pkgs.chromium
      ];
    })

    (lib.mkIf cfg.kde.enable {
      environment.systemPackages = with pkgs.kdePackages; [
        kio
        kio-extras
        ark
        kdenetwork-filesharing
        discover
        filelight
      ];
    })

    (lib.mkIf cfg.privacy.enable {
      programs = {
        seahorse.enable = true;
        ssh.askPassword = lib.mkForce "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";
        gnupg.agent = {
          enable = true;
          pinentryPackage = pkgs.pinentry-qt;
        };
      };
      environment.systemPackages = with pkgs; [
        gnome-keyring
        libsecret
        keepassxc
        kdePackages.kleopatra
        tor
        tor-browser
      ];
    })

    (lib.mkIf cfg.utils.enable {
      programs.dconf.enable = true;
      environment.systemPackages = with pkgs; [
        feh
        zenity
        libnotify
        pavucontrol
        pamixer
        pulseaudio
      ];
    })

    (lib.mkIf cfg.apps.enable {
      environment.systemPackages = with pkgs; [
        vesktop
        obsidian
        qalculate-qt
        qbittorrent
        mission-center
        gparted
        #rustdesk
      ];
    })

    (lib.mkIf cfg.obs.enable {
      programs.obs-studio = {
        enable = true;
        package = pkgs.obs-studio.override {cudaSupport = cfg.obs.cuda;};
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
          obs-gstreamer
          obs-vkcapture
        ];
      };
    })

    (lib.mkIf cfg.spotify.enable (let
      spicePkgs = spicetify-nix.legacyPackages.${system};
    in {
      programs.spicetify = {
        enable = true;
        enabledExtensions = with spicePkgs.extensions; [adblock hidePodcasts shuffle];
        enabledCustomApps = with spicePkgs.apps; [newReleases ncsVisualizer];
        enabledSnippets = with spicePkgs.snippets; [rotatingCoverart pointer];
      };
    }))
  ];
}
