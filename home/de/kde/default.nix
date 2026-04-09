{ pkgs, ... }:
{
  imports = [
    ../../features/ghostty.nix
    ../../features/fastfetch.nix
  ];

  /* home.packages = with pkgs; [
    kdePackages.discover
    kdePackages.kdenetwork-filesharing
    kdePackages.ark
    kdePackages.dolphin
    kdePackages.kleopatra
  ]; */

  /*
    home.file.".config/kwalletrc".text = ''
      [Wallet]
      Enabled=false

      [org.freedesktop.secrets]
      apiEnabled=false
    '';
  */
}
