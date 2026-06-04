{
  pkgs,
  lib,
  quickshell ? null,
  theme,
  ...
}:
{
  programs.dms-shell = {
    enable = theme == "dank";
  }
  // lib.optionalAttrs (theme == "dank") {
    systemd = {
      enable = true;
      restartIfChanged = true;
    };
    quickshell.package = quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
    enableClipboardPaste = true;
  };
}
