{
  description = "Khenzii's NixOS configuration";

  inputs = { 
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = { 
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { self, nixpkgs, home-manager, catppuccin, ... }: let 
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };

	# This variable gets passed to all the modules.
	modules-inputs = {
	  hostname = "nixos";
      username = "khenzii";
	};
  in {
    nixosConfigurations.${modules-inputs.hostname} = nixpkgs.lib.nixosSystem {
	  system = system;
      modules = [
		./shared/shared.nix
	    ./nixos/configuration.nix
		catppuccin.nixosModules.catppuccin
	  ];
	  specialArgs = { inputs = modules-inputs; };
    };

    homeConfigurations.${modules-inputs.username} = home-manager.lib.homeManagerConfiguration {
	  pkgs = pkgs;
      modules = [
		./shared/shared.nix
	    ./home-manager/home.nix	
		catppuccin.homeManagerModules.catppuccin
	  ];
	  extraSpecialArgs = { inputs = modules-inputs; };
    };
  };
}

