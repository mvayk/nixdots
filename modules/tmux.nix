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
        extraConfig = ''
            # settings
            set-option -g default-shell /run/current-system/sw/bin/zsh
            set-option -g default-terminal "tmux-256color"
            set-option -ga terminal-overrides ",xterm-256color:Tc,tmux-256color:Tc"
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

            # bindings
            unbind C-b
            set -g prefix C-e
            bind C-e send-prefix
            bind-key -T copy-mode-vi v send-keys -X begin-selection
            bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
            bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
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

            set-option -g status-style "bg=default"
            set-option -g status-position bottom
            set-option -g status-justify left
            set-option -g status-left-length 100
            set-option -g status-right-length 100
            set-option -g status-left "#[bg=default,fg=black]"
            set-option -g status-right "#[fg=brightblack] #S#[bg=default,fg=black]"
            set-option -g window-status-format "#[fg=brightblack] #I #W "
            set-option -g window-status-current-format "#[fg=brightblue,bold] #[fg=white,bold]#I #W #[fg=brightblue,bold]"
            set-option -g window-status-separator ""
        '';
                #
    };
}
