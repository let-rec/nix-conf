{
  inputs = { 
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils"; 
    
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    flake-utils,
    ...
  } @ inputs: let 
      outputs = self;
    in 
      flake-utils.lib.eachDefaultSystem (
        system: let
          pkgs = nixpkgs.legacyPackages.${system};
        in 
        {
          devShells.default = import ./shell.nix {inherit pkgs;};
          formatter = nixpkgs.legacyPackages.${system}.alejandra;
        }
      )
      // 
      {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
          modules = [
            ./nixos/configuration.nix
            home-manager.nixosModules.home-manager
           ];
           specialArgs = {
            inherit inputs outputs;
           };
        };
      };
}
