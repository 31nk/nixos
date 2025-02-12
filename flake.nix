{
  description = "A NixOS configuration with Home Manager integration and Catppuccin theme";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    catppuccin.url = "github:catppuccin/nix";  # Re-enable the Catppuccin input
  };

  outputs = { self, nixpkgs, home-manager, catppuccin, ... }: {
    # NixOS System Configuration
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix  # Your NixOS configuration file
          home-manager.nixosModules.home-manager  # Home Manager module for NixOS
          catppuccin.nixosModules.catppuccin  # Adding Catppuccin for system-wide theme
        ];
      };
    };

    # Home Manager Configuration
    homeConfigurations = {
      dorian = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          /home/dorian/nixos-config/home.nix  # Your Home Manager configuration file
          catppuccin.homeManagerModules.catppuccin  # Add Catppuccin theme here
        ];
      };
    };
  };
}

