{pkgs, ...}: {
  # [[ -f /etc/nixos/home/features/zsh/.p10k.zsh && ! -f ~/.p10k.zsh ]] && ln -s /etc/nixos/home/features/zsh/.p10k.zsh ~/.p10k.zsh
  ### home.file.".p10k.zsh".source = ./zsh/.p10k.zsh;
  home.packages = [pkgs.zsh-completions];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    autocd = true;

    history = {
      size = 50000;
      save = 50000;
      ignoreAllDups = true;
      share = true;
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "extract"
        "colored-man-pages"
        "copypath"
        "fzf"
        "zoxide"
        "history-substring-search"
      ];
    };

    plugins = [
      # {
      #   name = "powerlevel10k";
      #   src = pkgs.zsh-powerlevel10k;
      #   file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      # }
      {
        name = "you-should-use";
        src = "${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use";
      }
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
    ];

    shellAliases = {
      vim = "nvim";
      clear = "clear && mtodo list";
      cat = "bat --paging=never";
      ls = "lsd -l";
      ll = "lsd";
      la = "lsd -la";
      lt = "lsd --tree --depth 2";

      lla = "lsd -la";
      tree = "lsd --tree";
      sue = "sudo -E nvim";
      ghidra = "_JAVA_AWT_WM_NONREPARENTING=1 ghidra";
      #osu = "env SDL_VIDEODRIVER=wayland osu!";
      osu = "OSU_SDL3=1 osu!";

      #emacs = "emacsclient -c -a 'emacs'";

      #nix-rebuild = ''pushd /etc/nixos >/dev/null && sudo nixos-rebuild switch --flake ".#$(hostname)-$NIXOS_DE" && popd >/dev/null'';
      #nix-update = "pushd /etc/nixos >/dev/null && nix flake update && popd >/dev/null";
      nix-clean = "sudo nix-collect-garbage -d";

      ns = "niri msg action spawn --";

      top = "btop";
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

      export PATH="$HOME/.local/bin:$PATH"
      export PATH=$PATH:/home/mvayk/.spicetify
      export PATH="$HOME/.cargo/bin:$PATH"

      export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
      export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :200 {}'"
      export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
      export FZF_ALT_C_OPTS="--preview 'lsd --tree --depth 2 --color=always {}'"
      export FZF_DEFAULT_OPTS="--bind ctrl-j:down,ctrl-k:up,ctrl-h:backward-char,ctrl-l:forward-char"

      export MANPAGER="sh -c 'col -bx | bat -l man -p'"

      function y() {
          local tmp="$(mktemp -t yazi-cwd.XXXXXX)" cwd
          yazi "$@" --cwd-file="$tmp"
          cwd="$(<"$tmp")"
          [[ -n "$cwd" && "$cwd" != "$PWD" ]] && builtin cd -- "$cwd"
          rm -f -- "$tmp"
      }

      setopt CORRECT
      mkcd() { mkdir -p "$1" && cd "$1" }
      edit() { neovide "$@" & }

      # bindkey '^H' backward-char
      # bindkey '^L' forward-char
      bindkey "$terminfo[kcuu1]" history-substring-search-up
      bindkey "$terminfo[kcud1]" history-substring-search-down

      zstyle ':fzf-tab:*' fzf-bindings 'ctrl-j:down' 'ctrl-k:up'
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1 --color=always $realpath'
      zstyle ':completion:*' menu no

      _accept_suggestion_or_complete() {
          if [[ -n $POSTDISPLAY ]]; then
              zle forward-char
          else
              zle fzf-tab-complete
          fi
      }
      zle -N _accept_suggestion_or_complete
      bindkey '^I' _accept_suggestion_or_complete

      eval "$(direnv hook zsh)"
      eval "$(starship init zsh)"
      eval "$(atuin init zsh --disable-up-arrow)"
      eval "$(pay-respects zsh --alias)"

      mtodo list
    '';
    #~/.local/bin/entry
    #bindkey '^[[13;2u' autosuggest-accept
    #[[ "$TMUX_PANE" == "%0" || -z "$TMUX" ]] && fastfetch
    #[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
  };
}
