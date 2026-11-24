{
  zjstatus,
  pkgs,
  ...
}: {
  programs.zellij = {
    enable = true;

    settings = {
      show_startup_tips = false;
      session_serialization = false;
      mouse_mode = true;

      theme = "noctalia";
    };

    enableZshIntegration = false;
    #attachExistingSession = true;

    # load_plugins {
    #     "https://github.com/dj95/zjstatus/releases/latest/download/zjframes.wasm" {
    #         hide_frame_for_single_pane       "true"
    #         hide_frame_except_for_search     "true"
    #         hide_frame_except_for_fullscreen "true"
    #     }
    # }

    extraConfig = ''
      pane_frame_style "full"

      ui {
          pane_frames {
              hide_session_name true
          }
      }

      keybinds {
          unbind "Ctrl b"

          shared_except "tmux" "locked" {
              bind "Ctrl e" { SwitchToMode "Tmux"; }
          }

          tmux {
              bind "Ctrl e" { Write 5; SwitchToMode "Normal"; }
              bind "|" { NewPane "Right"; SwitchToMode "Normal"; }
              bind "-" { NewPane "Down"; SwitchToMode "Normal"; }
          }
      }
    '';
  };

  xdg.configFile."zellij/layouts/default.kdl".text = ''
    layout {
      pane
      pane size=1 borderless=true {
          plugin location="file:${zjstatus.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/zjstatus.wasm" {

              format_space "#[bg=default,fg=8]"
              format_left  "#[bg=default,fg=4,bold] {session}#[fg=8]: {tabs}"
              format_right "#[bg=default,fg=12,bold]{mode}{command_git_branch}#[fg=8]│#[fg=7] {datetime}"

              tab_normal         "#[fg=8] {index} {name} {sync_indicator}{fullscreen_indicator}{floating_indicator}"
              tab_active         "#[fg=12,bold]#[fg=7,bold]{index} {name} {sync_indicator}{fullscreen_indicator}{floating_indicator}#[fg=12,bold]"
              tab_separator      ""


              tab_sync_indicator       " "
              tab_fullscreen_indicator "□ "
              tab_floating_indicator   "󰉈 "
              mode_normal  "#[fg=10,bold] {name} "
              mode_locked  "#[fg=13,bold] {name} "
              mode_resize  "#[fg=3,bold] {name} "
              mode_pane    "#[fg=4,bold] {name} "
              mode_tab     "#[fg=5,bold] {name} "
              mode_scroll  "#[fg=6,bold] {name} "
              mode_session "#[fg=9,bold] {name} "
              mode_default_to_mode "normal"

              command_git_branch_command    "git branch --show-current"
              command_git_branch_format     "#[fg=3] {stdout} "
              command_git_branch_interval   "5"
              command_git_branch_rendermode "static"

              datetime        "{format}"
              datetime_format "%H:%M %d %b"
          }
        }
      }
  '';
}
