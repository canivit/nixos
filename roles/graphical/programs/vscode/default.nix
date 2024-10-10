{ pkgs, config, ... }:
let
  marketExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "vscode-icons";
      publisher = "vscode-icons-team";
      version = "11.12.0";
      sha256 = "sha256-jyc6m6lfwSYt5xg2H5TGdxheKptho87C7eN4xuU5IYg=";
    }
  ];

  settings = builtins.fromJSON (builtins.readFile ./settings.json);
in
{
  home-manager.users.can.programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      mskelton.one-dark-theme
      esbenp.prettier-vscode
      ms-python.python
      bbenoist.nix
      arrterian.nix-env-selector
      github.copilot
      ms-dotnettools.csharp
      # ms-vscode.cpptools
      ms-vscode.makefile-tools
      rust-lang.rust-analyzer
      ocamllabs.ocaml-platform
      elixir-lsp.vscode-elixir-ls
      mkhl.direnv
    ] ++ marketExtensions;

    keybindings = [
      {
        key = "ctrl+=";
        command = "editor.action.fontZoomIn";
      }

      {
        key = "ctrl+-";
        command = "editor.action.fontZoomOut";
      }

      {
        key = "ctrl+0";
        command = "editor.action.fontZoomReset";
      }

      {
        key = "ctrl+shift+v";
        command = "toggleVim";
      }
    ];

    userSettings = settings;
  };
}
