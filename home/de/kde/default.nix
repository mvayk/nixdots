{
  pkgs,
  inputs,
  kwin-effects-glass,
  ...
}: {
  imports = [
    ../../features/fastfetch.nix
    ../../features/ghostty.nix
  ];

  /*
     home.packages = with pkgs; [
    kdePackages.discover
    kdePackages.kdenetwork-filesharing
    kdePackages.ark
    kdePackages.dolphin
    kdePackages.kleopatra
  ];
  */

  /*
  home.file.".config/kwalletrc".text = ''
    [Wallet]
    Enabled=false

    [org.freedesktop.secrets]
    apiEnabled=false
  '';
  */

  home.packages = with pkgs; [
    plasma-panel-colorizer
    kwin-effects-glass.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
