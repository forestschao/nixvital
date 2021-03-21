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
    ../modules/dev/vim.nix
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
      machineLearning = true;
    };
  };

  environment.systemPackages = with pkgs; [
    darktable axel gimp pass
    zsh oh-my-zsh go
  ];

  #environment.variables = { GOROOT = [ "${pkgs.go.out}/share/go" ]; };

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    promptInit = "";

    ohMyZsh.enable = true;
    ohMyZsh.theme = "robbyrussell";
  };

  users.extraUsers = {
    "chao" = {
      shell = pkgs.zsh;
      useDefaultShell = false;
    };
  };

  systemd.extraConfig = ''
    DefaultLimitNOFILE=infinity
  '';
}
