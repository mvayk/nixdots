{...}: {
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    settings = builtins.fromJSON (builtins.readFile ./oh-my-posh/config.json);
  };
}
