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
    launchers.enable = mkSub cfg.enable "lutris, prism, osu, lunar, vinegar, misc games";
    emulation.enable = mkSub cfg.enable "pcsx2, retroarch";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.steam.enable {
      programs = {
        steam = {
          enable = true;
          extraCompatPackages = [pkgs.proton-ge-bin];
        };
        gamescope.enable = true;
        gamemode.enable = true;
      };
      environment.systemPackages = with pkgs; [
        mangohud
        protonup-rs
        protonup-qt
        protontricks
        steamtinkerlaunch
        xdotool
        xwininfo
      ];
    })

    (lib.mkIf cfg.wine.enable {
      environment.systemPackages = with pkgs; [wineWow64Packages.staging winetricks];
    })

    (lib.mkIf cfg.launchers.enable {
      environment.systemPackages = with pkgs; [
        lutris
        osu-lazer-bin
        prismlauncher
        lunar-client
        vinegar
        assaultcube
        kdePackages.kmines
        kdePackages.kpat
        # (heroic.override { extraPkgs = ps: with ps; [gamescope gamemode]; })
      ];
    })

    (lib.mkIf cfg.emulation.enable {
      environment.systemPackages = with pkgs; [pcsx2 retroarch];
    })
  ];
}
