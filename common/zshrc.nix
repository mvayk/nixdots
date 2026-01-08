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
            theme = "zeta";
            custom = "$HOME/.config/zsh/themes";
            #theme = "half-life";
        };
        envExtra = ''
            export NIX_LD=$(nix eval --impure --raw --expr 'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD')
            export TERM="tmux-256color"
            export COLORTERM="truecolor"
        '';
        shellAliases = {
            ls = "eza --icons -l";
            l = "eza --icons";
            emacs = "emacsclient -c -a 'emacs'";
            vim = "nvim";
            sue = "sudo -E nvim";
            nix-edit = "sudo -E nvim /etc/nixos/";
            #nix-rebuild = "pushd /etc/nixos && sudo nixos-rebuild switch --flake .#desktop; popd";
            nix-rebuild="pushd /etc/nixos && sudo nixos-rebuild switch --flake .#$(hostname); popd";
        };
        initContent = ''
            if [[ -z "$TMUX" ]]; then
                tmux new-session
            fi
            fastfetch

            eval "$(direnv hook zsh)"
        '';
    };
}
