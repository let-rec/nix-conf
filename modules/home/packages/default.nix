{
  config,
  pkgs,
  lib,
  ...
}: let
  # Package sets for different targets
  macos = import ./osx.nix {inherit pkgs;};
  linux = import ./linux.nix {inherit pkgs;};
  globals = import ./global.nix {inherit pkgs;};
in {
  options = {
    packages = {
      isMacOS = lib.mkOption {
        type = lib.types.bool;
        default = pkgs.stdenv.hostPlatform.isDarwin;
        description = "Is installed packages are MacOS targetted.";
      };
    };
  };

  config = {
    # Packages to be installed on my machine
    home.packages =
      if config.packages.isMacOS
      then globals ++ macos
      else globals ++ linux;
  };
}