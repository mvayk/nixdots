{
  lib,
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
    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
    enableClipboardPaste = true;
  };
}
