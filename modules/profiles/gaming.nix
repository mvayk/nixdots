{
  pkgs,
  lib,
  config,
  pkgs-stable,
  ...
}:
{
  options.profiles.dev = lib.mkEnableOption "gaming packages";

  config = lib.mkIf config.profiles.gaming {
    programs = {
      steam = {
        enable = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
      };
      gamescope.enable = true;
      gamemode.enable = true;
    };

    environment.systemPackages = with pkgs; [
      osu-lazer-bin
      prismlauncher
      /*
        (
          heroic.override
          {
            extraPkgs =
              ps:
              with ps; [
                gamescope
                gamemode
              ];
          }
        )
      */
      (pkgs-stable.lutris.override {
        extraPkgs = pkgs: [
          gamemode
        ];
      })
      xdotool
      xwininfo
      mangohud
      protonup-rs
      protonup-qt
      protontricks
      qemu
      pkgs-stable.wineWowPackages.stable
      winetricks
      steamtinkerlaunch
      vinegar
      linux-wallpaperengine
      kdePackages.kmines
      kdePackages.kpat
      pcsx2
      retroarch
    ];
  };
}
