{ config, pkgs, ... }:
{
    programs.tmux = {
        enable = true;
        shell = "${pkgs.zsh}/bin/zsh";
        terminal = "tmux-256color";
        historyLimit = 5000;
        baseIndex = 1;
        keyMode = "vi";
        escapeTime = 10;
        mouse = true;
        prefix = "C-e";
        plugins = with pkgs.tmuxPlugins; [
            resurrect
            {
                plugin = continuum;
                extraConfig = ''
                    set -g @continuum-restore 'on'
                    set -g @continuum-save-interval '10'
                '';
            }
            yank
            tmux-fzf
            tmux-sessionx
        ];
        extraConfig = ''
            # settings
            set-option -g default-shell /run/current-system/sw/bin/zsh
            set-option -g default-terminal "tmux-256color"
            set-option -ga terminal-overrides ",xterm-256color:Tc"
            set -ga terminal-overrides ",*256col*:Tc"
            set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
            set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'
            set-option -g history-limit 5000
            set-option -g mode-keys vi
            set-option -g escape-time 10
            set-option -g base-index 1
            set-option -g pane-base-index 1
            set-option -g aggressive-resize on
            set-option -g clock-mode-style 24
            set-option -g status on
            set-option -g mouse on
            set-option -g renumber-windows on
            set-option -g focus-events on

            # resurrect
            set -g @resurrect-capture-pane-contents 'on'
            set -g @resurrect-strategy-nvim 'session'

            # bindings
            unbind C-b
            set -g prefix C-e
            bind C-e send-prefix
            bind-key -T copy-mode-vi v send-keys -X begin-selection
            bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
            bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
            bind c new-window -c "#{pane_current_path}"
            bind h select-pane -L
            bind j select-pane -D
            bind k select-pane -U
            bind l select-pane -R
            bind -r H resize-pane -L 6
            bind -r J resize-pane -D 6
            bind -r K resize-pane -U 6
            bind -r L resize-pane -R 6
            bind x kill-pane
            bind \\ split-window -h -c "#{pane_current_path}"
            bind - split-window -v -c "#{pane_current_path}"
            unbind '"'
            unbind %
            bind r source-file ~/.tmux.conf \; display-message "Config reloaded!"

            # tmux-fzf
            bind-key f run-shell -b "${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf/main.sh"

            # sessionx
            set -g @sessionx-bind 'o'
            set -g @sessionx-preview-enabled 'true'
            set -g @sessionx-window-mode 'off'
            set -g @sessionx-filter-current 'false'

            set-option -g status-style "bg=default,fg=brightblack"
            set-option -g status-position bottom
            set-option -g status-justify left

            set-option -g status-left-length 80
            set-option -g status-right-length 80

            # left: session · path · git branch
            set-option -g status-left "\
#[fg=yellow]▊\
#[fg=blue,bold] #S\
#[fg=brightblack]:  \
"
            set-option -g status-right "\
#[fg=yellow] #(cd #{pane_current_path} && git branch --show-current 2>/dev/null | sed 's/.*/ &/') \
#[fg=brightblack]\
#[fg=green]#{=/16/…:pane_current_path}\
#[fg=brightblack] │\
#[fg=white] %H:%M %d %b \
#[fg=yellow]▊\
"
            # window tabs (centered via status-justify centre)
            set-option -g window-status-format "#[fg=brightblack]  #I #W  "
            set-option -g window-status-current-format "#[fg=brightblue,bold] #[fg=white,bold]#I #W #[fg=brightblue,bold]"
            set-option -g window-status-separator ""

            # pane borders
            set-option -g pane-border-style "fg=brightblack"
            set-option -g pane-active-border-style "fg=blue"

            # message / command bar
            set-option -g message-style "bg=default,fg=yellow"
        '';
    };
}
