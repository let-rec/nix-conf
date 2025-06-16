{ config, pkgs, ... }:

{
  imports = [];
  
  home = {
    stateVersion = "25.05";
    username = "letrec";
    homeDirectory = "/home/letrec";
  };

  home.packages = with pkgs; [
    git
    zed
  ];

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


  # Let's enable home-manager
  programs.home-manager.enable = true;

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      extensions = (with pkgs.vscode-extensions; [
        vscodevim.vim
        rust-lang.rust-analyzer
        jnoortheen.nix-ide
      ]);
    };
  };
}