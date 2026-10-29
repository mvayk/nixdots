{...}: {
  programs.swayimg = {
    initLua = ''
      swayimg.viewer.set_window_background(0x00000000)
      swayimg.viewer.set_image_background(0x00000000)
    '';
  };
}
