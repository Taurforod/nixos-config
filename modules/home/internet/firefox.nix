{pkgs, ...}: {
  home.packages = with pkgs; [
    firefoxpwa
  ];

  home.sessionVariables = {
    BROWSER = "firefox";
  };

  programs.firefox = {
    enable = true;

    nativeMessagingHosts = [
      pkgs.firefoxpwa
      pkgs.kdePackages.plasma-browser-integration
    ];

    # Официальный механизм установки через политики (без update_url!)
    policies = {
      ExtensionSettings = {
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        # AdGuard
        "adguardadblocker@adguard.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/adguard-adblocker/latest.xpi";
          installation_mode = "force_installed";
        };
        # Bitwarden
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
        # Dark Reader
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
        };
        # nightTab
        "{47bf427e-c83d-457d-9b3d-3db4118574bd}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/nighttab/latest.xpi";
          installation_mode = "force_installed";
        };
        # Plasma Integration
        "plasma-browser-integration@kde.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/plasma-integration/latest.xpi";
          installation_mode = "force_installed";
        };
        # PWA Extension
        "firefoxpwa@filips.si" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/pwas-for-firefox/latest.xpi";
          installation_mode = "force_installed";
        };
        # Тема Catppuccin Mocha - Mauve
        "{76aabc99-c1a8-4c1e-832b-d4f2941d5a7a}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/catppuccin-mocha-mauve-git/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };

    profiles."default" = {
      isDefault = true;

      settings = {
        "browser.startup.page" = 3;
        "extensions.pocket.enabled" = false;
      };
    };
  };
}
