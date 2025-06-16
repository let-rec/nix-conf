{ config, pkgs, ... }:

{
  imports = [];
  home.username = "letrec";
  home.hostname = "nixos";

  home.packages = with pkgs; [
    git
    zed
  ];

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