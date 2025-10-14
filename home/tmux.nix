{ config, pkgs, ... }:

{
    programs.tmux = {
        enable = true;
        shell = "${pkgs.zsh}/bin/zsh";
        terminal = "tmux-256color";
        historyLimit = 5000;
        keyMode = "vi";
        escapeTime = 10;
        baseIndex = 1;
        aggressiveResize = true;
        clock24 = true;
        sensibleOnTop = true;

        extraConfig = ''
            set -g prefix C-e
            set -g mouse on

            set -ga terminal-overrides ",xterm-256color:Tc,tmux-256color:Tc"
            set -g pane-base-index 1

            set -g status-style "fg=#a9b1d6,bg=#1a1b26"
            set -g pane-border-style "fg=#414868"
            set -g pane-active-border-style "fg=#3d59a1"
            set -g message-style "fg=#c0caf5,bg=#28344a"
            set -g status-left "#[fg=#3d59a1,bg=#16161e,bold] #S #[fg=#787c99,bg=#1a1b26] "
            set -g status-right "#[fg=#787c99,bg=#16161e] %Y-%m-%d #[fg=#3d59a1,bg=#16161e,bold] %H:%M "
            set -g window-status-current-style "fg=#3d59a1,bg=#16161e,bold"
            set -g window-status-style "fg=#787c99,bg=#16161e"
            '';
    };
}
