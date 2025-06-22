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
    zed-editor
  ];

nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };


  programs.home-manager.enable = true;
}