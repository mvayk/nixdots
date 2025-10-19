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
            theme = "afowler";
        };

        envExtra = ''
            export TERM="tmux-256color"
            export COLORTERM="truecolor"
        '';

        shellAliases = {
            ls = "eza --icons";
            emacs = "emacsclient -c -a 'emacs'";
            vim = "nvim";
            sue = "sudo -E nvim";

            nix-edit = "sudo -E nvim /etc/nixos/";
            nix-rebuild = "pushd /etc/nixos && sudo nixos-rebuild switch --flake .#laptop; popd";
        };

        initContent = ''
            if [[ -z "$TMUX" ]]; then
                tmux new-session
            fi
                fastfetch
            '';
    };
}
