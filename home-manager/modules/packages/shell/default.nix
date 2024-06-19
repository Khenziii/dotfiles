{ pkgs, ... }: let
  shared-config = {
    aliases = {
      rebuild = "rebuild-home && rebuild-system";
      rebuild-home = "mv .git .git-old && home-manager switch --flake '.#khenzii'; mv .git-old .git";
      rebuild-system = "mv .git .git-old && sudo nixos-rebuild switch --flake '.#nixos'; mv .git-old .git";
	};
  };
  
  zsh-config = import ./zsh.nix { inherit shared-config; inherit pkgs; };
  bash-config = import ./bash.nix { inherit shared-config; };
in 

{
  imports = [
    zsh-config
    bash-config
  ];
}
