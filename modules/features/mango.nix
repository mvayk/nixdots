{pkgs, ...}: {
  programs.mango = {
    enable = true;
  };

  services.displayManager.defaultSession = "mango";

  environment.systemPackages = with pkgs; [
    grim
    slurp
    satty
    wayfreeze
  ];
}
