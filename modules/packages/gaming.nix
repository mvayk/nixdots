{ pkgs, pkgs-stable, ... }:
{
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
}
