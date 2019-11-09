{ config, lib, pkgs, ... }:

let cfg = config.bds.web;

in {
  imports = [ ./cgit.nix ];

  options.bds.web = {
    enable = lib.mkEnableOption "Enable Hosted Web Services";
    serveHomePage = lib.mkEnableOption "Whether host web page.";
    serveFilerun = lib.mkEnableOption "Whether to host the filerun server.";
  };

  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 80 443 ];
    services.nginx = {
      enable = true;
      package = pkgs.nginxMainline;
      recommendedOptimisation = true;
      recommendedGzipSettings = true;
      recommendedProxySettings = true;

      # TODO(breakds): Make this per virtual host.
      clientMaxBodySize = "100m";

      virtualHosts = let template = {
        enableACME = true;
        forceSSL = true;
      }; in {
        # The home page
        "breakds.org" = lib.mkIf cfg.serveHomePage (template // {
          root = "/home/delegator/www/breakds.org";
        });
        "files.breakds.org" = lib.mkIf cfg.serveFilerun (template // {
          locations."/".proxyPass = "http://localhost:5962";
        });
        "${cfg.cgit.servedUrl}" = lib.mkIf cfg.cgit.enable (
          template // {
            locations."/".proxyPass = "http://localhost:5964";
          }
        );
      };
    };
  };
}
