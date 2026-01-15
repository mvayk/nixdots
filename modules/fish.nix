{ config, pkgs, ... }:
{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      # Start tmux if not already inside tmux
      if not set -q TMUX
          exec tmux new-session
      end

      # Show system info on shell start
      fastfetch

      # direnv hook
      direnv hook fish | source
    '';

    shellInit = ''
      # Better term & color support
      set -gx TERM tmux-256color
      set -gx COLORTERM truecolor

      # NIX_LD (for running dynamically linked binaries outside nix-shell)
      set -gx NIX_LD (${pkgs.nix}/bin/nix eval --impure --raw --expr '
        let pkgs = import <nixpkgs> {};
        in pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"'
      )
    '';

    shellAliases = {
      ls        = "eza --icons -l";
      l         = "eza --icons";
      emacs     = "emacsclient -c -a 'emacs'";
      vim       = "nvim";
      sue       = "sudo -E nvim";
      nix-edit  = "sudo -E nvim /etc/nixos/";
      nix-rebuild = "pushd /etc/nixos && sudo nixos-rebuild switch --flake .#$(hostname); popd";
    };
  };
}
