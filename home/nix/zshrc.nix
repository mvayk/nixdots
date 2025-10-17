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

            nix-edit = "sudo -E nvim /etc/nixos/home.nix";
            nix-rebuild = "pushd /etc/nixos && sudo nixos-rebuild switch --flake .; popd";
        };

        initContent = ''
            if [[ -z "$TMUX" ]]; then
                tmux new-session
            fi
                fastfetch
            '';
    };
}
