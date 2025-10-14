{ config, pkgs, ... }:

{
    programs.zsh = {
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        enableCompletion = true;
        oh-my-zsh = {
            enable = true;
            plugins = [
                "git"
            ];
            theme = "duellj";
        };

        envExtra = ''
            export TERM="tmux-256color"
            export COLORTERM="truecolor"
            '';

        shellAliases = {
            fastfetch = "fastfetch -l haiku_small";
            ls = "eza --icons";
            clear = "clear && fastfetch -l haiku_small";
            emacs = "emacsclient -c -a 'emacs'";
            vim = "nvim";
            sue = "sudo -E nvim";
            nix = "sudo -E nvim /etc/nixos/home.nix";
            nix-rebuild = "sudo nixos-rebuild switch --flake .";
        };

        initContent = ''
            if [[ -z "$TMUX" ]]; then
                tmux new-session
                    fi
                    fastfetch -l haiku_small
                    '';
    };
}
