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
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };


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