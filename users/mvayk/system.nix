{ pkgs, ... }:
{
  users.users.mvayk = {
# somehow differs on machines
    uid = 1000;
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
      "video"
      "audio"
      "plugdev"
      "input"
    ];
    hashedPasswordFile = "/run/secrets/mvayk-password";
  };
}
