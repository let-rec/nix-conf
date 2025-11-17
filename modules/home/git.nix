{...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    
    signing = {
      signByDefault = true;
      key = "06F6FCE379C490BAC47F4ACEE9180B76B6DB2E66";
    };

    settings = {
      user = {
        name = "let-rec";
        email = "toxtayevhamidulloh6997@gmail.com";
      };
      init.defaultBranch = "main";
      http.sslVerify = false;
      pull.rebase = false;
    };
  };

  programs.difftastic = {
    enable = true;
    git.enable = true;
  };
}
