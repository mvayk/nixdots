{
  inputs,
  zjstatus,
  pkgs,
  ...
}: let
  zjstatusPane = ''
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
  '';

  pwn = pkgs.writeShellApplication {
    name = "pwn";
    runtimeInputs = [
      pkgs.zellij
      pkgs.coreutils
      pkgs.procps
      inputs.pwndbg.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
    text = ''
      # usage: pwn <pid|process-name>
      TARGET=''${1:?usage: pwn <pid|process-name>}
      GDB=''${GDB:-pwndbg}

      if [[ "$TARGET" =~ ^[0-9]+$ ]]; then
        PID=$TARGET
      else
        PID=$(pgrep -n -x "$TARGET") || { echo "no process named $TARGET" >&2; exit 1; }
      fi
      echo "attaching to $PID"

      D=$(mktemp -d /tmp/pwndbg.XXXXXX)
      trap 'rm -rf "$D"' EXIT

      printf 'exec %s -q -x %q -p %q\n' "$GDB" "$D/init.gdb" "$PID" > "$D/gdb.sh"
      chmod +x "$D/gdb.sh"

      cat > "$D/init.gdb" <<EOF
      set context-sections "regs disasm stack backtrace"
      python
      import os, time
      d = "$D"
      for s in ("regs", "disasm", "stack", "backtrace"):
          p = os.path.join(d, s)
          while not (os.path.exists(p) and os.path.getsize(p)):
              time.sleep(0.05)
          tty = open(p).read().strip()
          gdb.execute(f"contextoutput {s} {tty} True")
      end
      context
      EOF

      cat > "$D/layout.kdl" <<EOF
      layout {
          new_tab_template {
              pane
      ${zjstatusPane}
          }

          tab name="pwn" focus=true {
              pane split_direction="vertical" {
                  pane name="gdb" size="45%" focus=true command="$D/gdb.sh"
                  pane split_direction="horizontal" {
                      pane name="disasm" size="40%" command="sh" {
                          args "-c" "tty > $D/disasm; exec sleep infinity"
                      }
                      pane split_direction="vertical" size="45%" {
                          pane name="regs" command="sh" {
                              args "-c" "tty > $D/regs; exec sleep infinity"
                          }
                          pane name="stack" command="sh" {
                              args "-c" "tty > $D/stack; exec sleep infinity"
                          }
                      }
                      pane name="backtrace" size="15%" command="sh" {
                          args "-c" "tty > $D/backtrace; exec sleep infinity"
                      }
                  }
              }
      ${zjstatusPane}
          }
      }
      EOF

      zellij --session "pwn-$$" --new-session-with-layout "$D/layout.kdl"
    '';
  };
in {
  home.packages = [pwn];

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
      ${zjstatusPane}
    }
  '';
}
