{ config, pkgs, ... }:

{
  imports = [
    ./base
    ../modules/users
    ../modules/desktop
    ../modules/IoT/apple-devices.nix
    ../modules/steam.nix
    ../modules/vm.nix
    ../modules/dev/python-environment.nix
    ../modules/dev/vscode.nix
    # ../modules/dev/vim.nix
  ];

  vital.machineType = "desktop";

  # +----------+
  # | Desktop  |
  # +----------+

  vital.desktop = {
    enable = true;
    xserver.displayManager = "gdm";
    xserver.dpi = 100;
    nvidia = {
      enable = true;
    };
  };

  # For ROS
  networking.firewall.allowedTCPPorts = [ 11311 ];

  # +------------+
  # | Gaming     |
  # +------------+

  # Support Logitech G29 Steering Wheel
  services.udev.packages = with pkgs; [
    usb-modeswitch-data
  ];

  # +-------------+
  # | Development |
  # +-------------+

  vital.dev.python = {
    batteries = {
      machineLearning = false;
    };
  };

  environment.systemPackages = with pkgs; [
    darktable axel gimp pass
    oh-my-zsh
  ];

  programs.zsh.enable = true;
  programs.zsh.interactiveShellInit = ''
    export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/

    # Customize your oh-my-zsh options here
    ZSH_THEME="Agnoster"

    HISTFILESIZE=500000
    HISTSIZE=500000
    setopt SHARE_HISTORY
    setopt HIST_IGNORE_ALL_DUPS
    setopt HIST_IGNORE_DUPS
    setopt INC_APPEND_HISTORY
    autoload -U compinit && compinit
    unsetopt menu_complete
    setopt completealiases

    if [ -f ~/.aliases ]; then
      source ~/.aliases
    fi

    source $ZSH/oh-my-zsh.sh
  '';

  users.extraUsers = {
    "chao" = {
      shell = pkgs.zsh;
      useDefaultShell = false;
    };
  };
}
