{
  pkgs,
  lib,
  config,
  mkSub,
  ...
}: let
  cfg = config.my.gaming;
in {
  options.my.gaming = {
    enable = lib.mkEnableOption "everything";
    steam.enable = mkSub cfg.enable "steam, proton, gamescope, gamemode, mangohud";
    wine.enable = mkSub cfg.enable "wine (staging) + winetricks";
    launchers.enable = mkSub cfg.enable "prism, osu, lunar, vinegar";
    games.enable = mkSub cfg.enable "assaultcube kde games";
    other.enable = mkSub cfg.enable "lutris, pcsx2, retroarch";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.steam.enable {
      programs = {
        steam = {
          enable = true;
          gamescopeSession.enable = true;
          extraCompatPackages = [pkgs.proton-ge-bin];
        };
        gamescope = {
          enable = true;
          capSysNice = true;
        };
        gamemode.enable = true;
      };
      environment.systemPackages = with pkgs; [
        mangohud

        # protonup-rs
        # protonup-qt
        # protontricks
        # steamtinkerlaunch
        # xdotool
        # xwininfo
      ];
    })

    (lib.mkIf cfg.wine.enable {
      environment.systemPackages = with pkgs; [wineWow64Packages.staging winetricks];
    })

    (lib.mkIf cfg.launchers.enable {
      environment.systemPackages = with pkgs; [
        osu-lazer-bin
        prismlauncher
        lunar-client
        #vinegar
        # (heroic.override { extraPkgs = ps: with ps; [gamescope gamemode]; })
      ];
    })

    (lib.mkIf cfg.games.enable {
      environment.systemPackages = with pkgs; [kdePackages.kmines kdePackages.kpat assaultcube];
    })

    (lib.mkIf cfg.other.enable {
      environment.systemPackages = with pkgs; [pcsx2 retroarch lutris];
    })
  ];
}
