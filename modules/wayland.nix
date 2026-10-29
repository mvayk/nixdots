{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wl-clipboard
    swayimg
    kdePackages.dolphin
  ];
}
