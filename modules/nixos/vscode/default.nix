{ pkgs, ... }: 
{
    pkgs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;
        extensions = (with pkgs.vscode-extensions; [
            vscodevim.vim
            rust-lang.rust-analyzer
            jnoortheen.nix-ide
            dbaeumer.vscode-eslint
            tamasfe.even-better-toml
            bierner.markdown-mermaid
            pkief.material-icon-theme
            pkief.material-product-icons
       ]);
      };
   };
}