{...}: {
  config = {
    nixpkgs = {
      # Configure your nixpkgs instance
      config = {
        # Wallahi, forgive me RMS...
        allowUnfree = true;
        # Workaround for https://github.com/nix-community/home-manager/issues/2942
        allowUnfreePredicate = _: true;
        # Let the system use fucked up programs
        allowBroken = true;
      };
    };
  };
}