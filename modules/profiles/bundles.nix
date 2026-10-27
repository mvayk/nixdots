{
  lib,
  config,
  ...
}: let
  cfg = config.my.bundles;
in {
  options.my.bundles = {
    server.enable = lib.mkEnableOption "cli + network";
    workstation.enable = lib.mkEnableOption "full workstation (server + desktop, dev, media, ...)";
    gaming.enable = lib.mkEnableOption "workstation + gaming";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.server.enable {
      my.cli.enable = lib.mkDefault true;
      my.network.enable = lib.mkDefault true;
    })

    (lib.mkIf cfg.workstation.enable {
      my.bundles.server.enable = lib.mkDefault true;
      my.desktop.enable = lib.mkDefault true;
      my.dev.enable = lib.mkDefault true;
      my.ai.enable = lib.mkDefault true;
      my.media.enable = lib.mkDefault true;
      my.hardware.enable = lib.mkDefault true;
      my.virtualisation.enable = lib.mkDefault true;
    })

    (lib.mkIf cfg.gaming.enable {
      my.bundles.workstation.enable = lib.mkDefault true;
      my.gaming.enable = lib.mkDefault true;
    })
  ];
}
