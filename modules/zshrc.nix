{ config, pkgs, machine, theme, ... }:
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
            export NIX_LD=$(nix eval --impure --raw --expr 'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD')
            export TERM="tmux-256color"
            export COLORTERM="truecolor"
            export MANPAGER="bat"
        '';
        shellAliases = {
            ls = "eza --icons -l";
            l = "eza --icons";
            emacs = "emacsclient -c -a 'emacs'";
            vim = "nvim";
            sue = "sudo -E nvim";
            #sudo chown -R mvayk:users /etc/nixos
            nix-edit = "nvim /etc/nixos/";
            #nix-rebuild = "pushd /etc/nixos && sudo nixos-rebuild switch --flake .#desktop; popd";
            nix-rebuild-current = "pushd /etc/nixos && sudo nixos-rebuild switch --flake .#$NIXOS_MACHINE-$NIXOS_THEME; popd";
            launch-osu = "env SDL_VIDEODRIVER=wayland osu!";
        };
        initContent = ''
            if [[ -z "$TMUX" ]]; then
                tmux new-session
            fi

            bindkey '^[[13;2u' autosuggest-accept
            fastfetch
            nix-rebuild() {
                noglob pushd /etc/nixos >/dev/null
                sudo nixos-rebuild switch --flake "$@"
                popd >/dev/null
            }

            eval "$(direnv hook zsh)"
        '';
    };
}
