{...}: {
  programs.zellij = {
    enable = true;

    settings = {
      show_startup_tips = false;
      session_serialization = true;
      mouse_mode = true;

      theme = "noctalia";
      ui.pane_frames.rounded_corners = true;
    };
    enableZshIntegration = true;
    attachExistingSession = true;

    extraConfig = ''
      keybinds {
          unbind "Ctrl b"

          shared_except "tmux" "locked" {
              bind "Ctrl e" { SwitchToMode "Tmux"; }
          }

          tmux {
              bind "Ctrl e" { Write 5; SwitchToMode "Normal"; }
          }
      }
    '';
  };
}
