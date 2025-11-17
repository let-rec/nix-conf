{
  pkgs,
  lib,
}: {
  # List your module files here
  fastfetch = import ./fastfetch.nix { inherit pkgs; };
  git = import ./git.nix { inherit pkgs; };
  zsh = import ./zsh.nix { inherit pkgs; };
  vscode = import ./vscode.nix { inherit pkgs; };
  bash = import ./bash.nix { inherit pkgs; };
  direnv = import ./direnv.nix { inherit pkgs; };
  # firefox = import ./firefox.nix { inherit pkgs; };
}
