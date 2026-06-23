{pkgs, ...}: {
  # [[ -f /etc/nixos/home/features/zsh/.p10k.zsh && ! -f ~/.p10k.zsh ]] && ln -s /etc/nixos/home/features/zsh/.p10k.zsh ~/.p10k.zsh
  ### home.file.".p10k.zsh".source = ./zsh/.p10k.zsh;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "copypath"
        "copyfile"
        "dirhistory"
        "extract"
        "fzf"
        "colored-man-pages"
        "command-not-found"
      ];
      theme = "mh";
    };

    plugins = [
      # {
      #   name = "powerlevel10k";
      #   src = pkgs.zsh-powerlevel10k;
      #   file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      # }
      {
        name = "you-should-use";
        src = pkgs.zsh-you-should-use;
      }
      {
        name = "per-directory-history";
        src = pkgs.zsh-history-substring-search;
      }
    ];

    shellAliases = {
      ls = "eza --icons -l";
      l = "eza --icons";
      ll = "eza --icons -la";
      tree = "eza --tree --icons";
      vim = "nvim";
      sue = "sudo -E nvim";
      ghidra = "_JAVA_AWT_WM_NONREPARENTING=1 ghidra";
      osu = "env SDL_VIDEODRIVER=wayland osu!";
      #emacs = "emacsclient -c -a 'emacs'";

      #nix-rebuild = ''pushd /etc/nixos >/dev/null && sudo nixos-rebuild switch --flake ".#$(hostname)-$NIXOS_DE" && popd >/dev/null'';
      #nix-update = "pushd /etc/nixos >/dev/null && nix flake update && popd >/dev/null";
      nix-clean = "sudo nix-collect-garbage -d";

      ns = "niri msg action spawn --";

      cat = "bat --style=full";
      grep = "rg";
      top = "btm";
      du = "dust";
    };

    envExtra = ''
      export COLORTERM="truecolor"

      export NIX_LD=$(nix eval --impure --raw --expr \
        'let pkgs = import <nixpkgs> {}; in pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"' \
        2>/dev/null)
    '';

    # if [[ -z "$TMUX" ]]; then
    #   tmux attach 2>/dev/null || tmux new-session
    # fi
    initContent = ''
                if [[ -n "$TMUX" ]]; then
                  export TERM="tmux-256color"
                fi


                eval "$(zoxide init zsh)"
                eval "$(direnv hook zsh)"

                edit() { neovide "$@" & }

      _accept_suggestion_or_complete() {
        if [[ -n $POSTDISPLAY ]]; then
          zle forward-char
        else
          zle expand-or-complete
        fi
      }
      zle -N _accept_suggestion_or_complete
      bindkey '^I' _accept_suggestion_or_complete
    '';
    #bindkey '^[[13;2u' autosuggest-accept
    #[[ "$TMUX_PANE" == "%0" || -z "$TMUX" ]] && fastfetch
    #eval "$(starship init zsh)"
    #[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
  };
}
