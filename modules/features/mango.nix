{pkgs, ...}: {
  programs.mango = {
    enable = true;
  };

  services.displayManager.defaultSession = "mango";

  xdg = {
    portal = {
      enable = true;
      wlr = {
        enable = true;
        settings.screencast = {
          chooser_type = "simple";
          chooser_cmd = "${pkgs.slurp}/bin/slurp -f 'Monitor: %o' -or";
        };
      };
      extraPortals = with pkgs; [
        #pkgs.xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      config = {
        common = {
          default = ["gtk"];
          "org.freedesktop.impl.portal.ScreenCast" = ["wlr"];
          "org.freedesktop.impl.portal.Screenshot" = ["wlr"];
        };
      };
    };
  };
  environment.systemPackages = with pkgs; [
    grim
    slurp
    satty
    wayfreeze
  ];
}
