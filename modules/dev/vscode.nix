{ config, lib, pkgs, ... }:

let
  extensions = (with pkgs.vscode-extensions; [
    bbenoist.Nix
    (pkgs.callPackage <nixpkgs/pkgs/misc/vscode-extensions/remote-ssh> {
      useLocalExtensions = true;
    })
  ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "vscode-icons";
      publisher = "vscode-icons-team";
      version = "9.7.0";
      sha256 = "0332i23wdxpjppawprs1z0fv73nlrh04v71jqkwlc7p38zb5xpqh";
    }
    {
      name = "gitlens";
      publisher = "eamodio";
      version = "10.2.0";
      sha256 = "0qnq9lr4m0j0syaciyv0zbj8rwm45pshpkagpfbf4pqkscsf80nr";
    }
    {
      name = "path-intellisense";
      publisher = "christian-kohler";
      version = "1.4.2";
      sha256 = "0i2b896cnlk1d23w3jgy8wdqsww2lz201iym5c1rqbjzg1g3v3r4";
    }
    {
      name = "theme-dracula";
      publisher = "dracula-theme";
      version = "2.22.3";
      sha256 = "0wni9sriin54ci8rly2s68lkfx8rj1cys6mgcizvps9sam6377w6";
    }
    # Syntax highlighting for BUILD files.
    {
      name = "bazel-code";
      publisher = "DevonDCarew";
      version = "0.1.9";
      sha256 = "0lsb4vlqwqqlm0yzljhl8sl151j41lxlpj9wh82m90v59qibpkkf";
    }
    # Bazel Plugin for Projects
    {
      name = "vscode-bazel";
      publisher = "BazelBuild";
      version = "0.3.0";
      sha256 = "0rlja1hn2n6fyq673qskz2a69rz8b0i5g5flyxm5sfi8bcz8ms05";
    }
    # Vim
    {
      name = "vim";
      publisher = "vscodevim";
      version  = "1.18.5";
      sha256 = "0cbmmhkbr4f1afk443sgdihp2q5zkzchbr2yhp7bm5qnv7xdv5l4";
    }
  ];
  
  customized-vscode = pkgs.vscode-with-extensions.override {
    vscodeExtensions = extensions;
  };
in {
  environment.systemPackages = [
    customized-vscode
  ];
}
