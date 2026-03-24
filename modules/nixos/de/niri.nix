{
  config,
  pkgs,
  lib,
  quickshell ? null,
  ...
}:
{
  programs.niri.enable = true;

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
