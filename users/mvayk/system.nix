{ pkgs, ... }:
{
  users.users.mvayk = {
    uid          = 1001;
    isNormalUser = true;
    shell        = pkgs.zsh;
    extraGroups  = [
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
