{config, ...}: {
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Vague";
      cursor-style-blink = true;
      cursor-style = "underline";
      shell-integration = "detect";
      shell-integration-features = "no-cursor";
      keybind = "ctrl+backspace=text:\\x1b\\x7f";
      window-padding-balance = true;
      confirm-close-surface = false;
      font-family = "VictorMono Nerd Font";
      adjust-cell-height = "+10%";
    };
  };
}
