{
  config,
  pkgs,
  lib,
  quickshell ? null,
  inputs,
  ...
}:
{

  /*
    nixpkgs.overlays = [
      inputs.niri.overlays.niri

      (final: prev: {
        niri-unstable = prev.niri-unstable.override {
          src = inputs.niri-blur;
        };
      })
    ];
  */

  programs.niri = {
    enable = true;
    /*
      package = pkgs.niri-unstable.override {
        src = inputs.niri-blur;
      };
    */
  };

  services.displayManager.defaultSession = "niri";

  programs.dms-shell = lib.mkIf (config.programs.dms-shell.enable or false) {
    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    quickshell.package =
      quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;

    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
    enableClipboardPaste = true;
  };
}
