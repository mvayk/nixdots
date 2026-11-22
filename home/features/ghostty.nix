{pkgs, ...}: {
  programs.ghostty = {
    settings = {
      keybind = [
        "ctrl+backspace=text:\\x1b\\x7f"
        "ctrl+shift+c=copy_to_clipboard:plain"
      ];
      window-padding-color = "extend";
      confirm-close-surface = false;
      #copy-on-select = "clipboard";
      clipboard-write = "allow";
      shell-integration-features = "ssh-env,ssh-terminfo";
      theme = "Builtin Pastel Dark";
    };
  };
}
