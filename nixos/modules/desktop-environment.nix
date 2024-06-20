{ pkgs, ... }:

{
  # Explicitly enable touchpad support (most desktop 
  # environments (hyprland included) support this by default).
  # services.xserver.libinput.enable = true;

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = false;
  programs.hyprland = {
    enable = true;
	xwayland.enable = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Wayland doesn't provide a scren sharing API by default.
  # According to theirs philosophy, the desktop environment
  # should implement this. Thus the portals.
  xdg.portal = {
    enable = true;
	extraPortals = with pkgs; [ 
      xdg-desktop-portal-hyprland 
	];
  };
}

