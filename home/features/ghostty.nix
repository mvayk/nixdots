{config, ...}: {
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Carbonfox";
      cursor-style-blink = true;
      shell-integration = "detect";
      shell-integration-features = "no-cursor";
      keybind = "ctrl+backspace=text:\\x1b\\x7f";
      window-padding-balance = true;
      confirm-close-surface = false;
    };
  };
}
