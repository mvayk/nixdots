{
  pkgs,
  lib,
  config,
  mkSub,
  ...
}: let
  cfg = config.my.network;
in {
  options.my.network = {
    enable = lib.mkEnableOption "network tools";
    tools.enable = mkSub cfg.enable "inetutils, dnsmasq, iw, nmap";
    smb.enable = mkSub cfg.enable "samba + cifs-utils";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.tools.enable {
      environment.systemPackages = with pkgs; [inetutils dnsmasq iw nmap];
    })
    (lib.mkIf cfg.smb.enable {
      environment.systemPackages = with pkgs; [samba cifs-utils];
    })
  ];
}
