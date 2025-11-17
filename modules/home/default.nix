{
  pkgs,
  lib,
}: {
  # List your module files here
  fastfetch = import ./fastfetch;
  git = import ./git;
  zsh = import ./zsh;
  vscode = import ./vscode;
  bash = import ./bash;
  direnv = import ./direnv;
  firefox = import ./firefox;
}
