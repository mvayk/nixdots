{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };

    shellAliases = {
      ls = "eza --icons -l";
      l = "eza --icons";
      ll = "eza --icons -la";
      tree = "eza --tree --icons";
      vim = "nvim";
      sue = "sudo -E nvim";
      emacs = "emacsclient -c -a 'emacs'";

      nix-rebuild = ''pushd /etc/nixos >/dev/null && sudo nixos-rebuild switch --flake ".#$(hostname)-$NIXOS_DE" && popd >/dev/null'';
      nix-update = "pushd /etc/nixos >/dev/null && nix flake update && popd >/dev/null";
      nix-clean = "sudo nix-collect-garbage -d";
    };

    envExtra = ''
      export TERM="tmux-256color"
      export COLORTERM="truecolor"

      export NIX_LD=$(nix eval --impure --raw --expr \
        'let pkgs = import <nixpkgs> {}; in pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"' \
        2>/dev/null)
    '';

    initContent = ''
      if [[ -z "$TMUX" ]]; then
        tmux new-session
      fi

      bindkey '^[[13;2u' autosuggest-accept

      eval "$(zoxide init zsh)"
      eval "$(direnv hook zsh)"

      [[ "$TMUX_PANE" == "%0" || -z "$TMUX" ]] && fastfetch

      nix-rebuild-to() {
        noglob pushd /etc/nixos >/dev/null
        sudo nixos-rebuild switch --flake "$@"
        popd >/dev/null
      }
    '';
  };
}
