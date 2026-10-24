{...}: {
  programs.mango = {
    enable = true;
  };

  services.displayManager.defaultSession = "mango";
}
