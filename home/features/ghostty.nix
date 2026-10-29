{pkgs, ...}: {
  programs.ghostty = {
    settings = {
      window-decoration = false;
      keybind = "ctrl+backspace=text:\\x1b\\x7f";
      window-padding-color = "extend";
      confirm-close-surface = false;
    };
  };
}
