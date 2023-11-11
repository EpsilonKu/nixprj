# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, outputs, config, pkgs, lib, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.consoleLogLevel = 0;
  boot.kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "i915.fastboot=1"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  boot.plymouth = {
    enable = true;
    theme = "breeze";
  };
  # environment.variables = {
  #   _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  # };

  boot.loader = {
    timeout = lib.mkDefault 0;
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      editor = false;
      configurationLimit = 100;
    };
  };
  boot.initrd.systemd.enable = true;
  console = {
    useXkbConfig = true;
    earlySetup = false;
  };
 
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    # ipv4.addresses =[ {
    #     address = "192.168.1.157";
    #     prefixLength = 24;
    #   }];
    # };
    firewall = {
      allowedTCPPorts = [ 8082 3010 ];
      allowedUDPPorts = [ 8082 3010 ];
    };
    # wireless.enable = true;
  };

  systemd.targets."multi-user".conflicts = [ "getty@tty1.service" ];
 
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking

  # Set your time zone.
  time.timeZone = "Asia/Almaty";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "kk_KZ.UTF-8";
    LC_IDENTIFICATION = "kk_KZ.UTF-8";
    LC_MEASUREMENT = "kk_KZ.UTF-8";
    LC_MONETARY = "kk_KZ.UTF-8";
    LC_NAME = "kk_KZ.UTF-8";
    LC_NUMERIC = "kk_KZ.UTF-8";
    LC_PAPER = "kk_KZ.UTF-8";
    LC_TELEPHONE = "kk_KZ.UTF-8";
    LC_TIME = "kk_KZ.UTF-8";
  };

  nixpkgs.config.permittedInsecurePackages = [
                "openssl-1.1.1v"
                "openssl-1.1.1w"
              ];
  nixpkgs.overlays = [ 
    (final: prev:
        {
          # awesome = inputs.nixpkgs-f2k.packages.${pkgs.system}.awesome-git;
          newm = inputs.newmpkg.packages.${pkgs.system}.newm-atha;
        })
  ]; 
  services.fprintd.enable = true;

  services.udev.extraRules = ''
    ACTION=="add", KERNEL=="ttyUSB[0-9]*", SUBSYSTEM=="tty", SUBSYSTEMS=="usb", ATTRS{devpath}=="[0-9]*.4", ATTRS{product}=="CP2102 USB to UART Bridge Controller", SYMLINK+="alcotester"
    ACTION=="add", KERNEL=="ttyUSB[0-9]*", SUBSYSTEM=="tty", SUBSYSTEMS=="usb", ATTRS{devpath}=="[0-9]*.3", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60", SYMLINK+="ecg"
    #ACTION=="add", KERNEL=="ttyUSB[0-9]*", SUBSYSTEM=="tty", SUBSYSTEMS=="usb", ATTRS{devpath}=="[0-9]*.3", ATTRS{product}=="CP2102 USB to UART Bridge Controller", SYMLINK+="alcotester"
    ACTION=="add", KERNEL=="ttyUSB[0-9]*", SUBSYSTEM=="tty", SUBSYSTEMS=="usb", ATTRS{manufacturer}=="Prolific Technology Inc.", ATTRS{idProduct}=="23c3", ATTRS{idVendor}=="067b", SYMLINK+="tonometer"
    ACTION=="add", KERNEL=="ttyUSB[0-9]*", SUBSYSTEM=="tty", SUBSYSTEMS=="usb", ATTRS{product}=="JXB183", SYMLINK+="thermometer"
    ACTION=="add", KERNEL=="video[02468]*", SUBSYSTEM=="video4linux", SUBSYSTEMS=="usb", ATTRS{devpath}=="[0-9]*.1", ATTRS{idProduct}=="3035", ATTRS{idVendor}=="0bda", SYMLINK+="cam1"
    ACTION=="add", KERNEL=="video[02468]*", SUBSYSTEM=="video4linux", SUBSYSTEMS=="usb", ATTRS{devpath}=="[0-9]*.2", ATTRS{idProduct}=="3035", ATTRS{idVendor}=="0bda", SYMLINK+="cam0"
    #ACTION=="add", KERNEL=="video[02468]*", SUBSYSTEM=="video4linux", SUBSYSTEMS=="usb", ATTRS{interface}=="USB Color Camera", SYMLINK+="cam1"
    #ACTION=="add", KERNEL=="video[02468]*", SUBSYSTEM=="video4linux", SUBSYSTEMS=="usb", ATTRS{interface}=="USB IR Camera", SYMLINK+="cam0"
    ACTION=="add", KERNEL=="ttyUSB[0-9]*", SUBSYSTEM=="tty", SUBSYSTEMS=="usb", ATTRS{manufacturer}=="FTDI", ATTRS{idProduct}=="6001", ATTRS{idVendor}=="0403", ATTRS{serial}=="A505JYQP|AD0KCRK8|AQ02Z7MF|AL02VI4W|AL02VI6U|AL02VI71|AQ02Z7MI|AQ>
    ACTION=="add", KERNEL=="video[02468]*", SUBSYSTEM=="video4linux", SUBSYSTEMS=="usb", ATTR{name}=="USB 2.0 Camera: HD USB Camera", ATTRS{idProduct}=="9530", ATTRS{idVendor}=="05a3", SYMLINK+="cam2"
    ACTION=="add", KERNEL=="video[02468]*", SUBSYSTEM=="video4linux", SUBSYSTEMS=="usb", ATTR{name}=="HD USB Camera: HD USB Camera", SYMLINK+="cam2"
    ACTION=="add", KERNEL=="video[02468]*", SUBSYSTEM=="video4linux", SUBSYSTEMS=="usb", ATTR{name}=="Logitech Webcam C930e", SYMLINK+="cam4

    ACTION=="add", KERNEL=="video[02468]*", SUBSYSTEM=="video4linux", SUBSYSTEMS=="usb", ATTRS{interface}=="USB Video Device", SYMLINK+="cam0"
    ACTION=="add", KERNEL=="video[02468]*", SUBSYSTEM=="video4linux", SUBSYSTEMS=="usb", ATTRS{devpath}=="3", ATTRS{idProduct}=="3828", ATTRS{idVendor}=="058f", SYMLINK+="cam0"

    ACTION=="add", KERNEL=="video[02468]*", SUBSYSTEM=="video4linux", SUBSYSTEMS=="usb", ATTRS{devpath}=="4", ATTRS{idProduct}=="279f", ATTRS{idVendor}=="eb1a", SYMLINK+="cam1"

    ACTION=="add", KERNEL=="video[02468]*", SUBSYSTEM=="video4linux", SUBSYSTEMS=="usb", ATTRS{interface}=="USB2.0_CAM2", SYMLINK+="cam0"
    ACTION=="add", KERNEL=="video[02468]*", SUBSYSTEM=="video4linux", SUBSYSTEMS=="usb", ATTRS{interface}=="USB2.0_CAM1", SYMLINK+="cam1"

    ACTION=="add", KERNEL=="ttyACM[0-9]*", SUBSYSTEM=="tty", SUBSYSTEMS=="usb", ATTRS{product}=="USB Adapter Z2-USB", SYMLINK+="cardreader"
    # Your rule goes here
  '';

  services.openssh = {
    enable = true;
    # ports = [3010 8082];
    settings.PasswordAuthentication = true;
    # settings.KbdInteractiveAuthentication = false;
  };
  services.earlyoom = {
    enable = true;
    extraArgs = [
     "-g" "--avoid '^(init|Xorg|pantheon|gnome|gcd|plank|wingpanel|gala)$'"
     "--prefer '^(firefox|java|npm|onlyoffice)$'"
    ];

  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  services.xserver = {
     enable = true;
     excludePackages = [ pkgs.xterm ];
     xautolock.time = 999;
  #   displayManager = {
  #     lightdm.enable = true;
  #     defaultSession = "none+awesome";
  };
  #   windowManager.awesome = {
  #     enable = true;
  #     package = pkgs.awesome.overrideAttrs (old: {
  #       src = pkgs.fetchFromGitHub {
  #         owner = "awesomeWM";
  #         repo = "awesome";
  #         rev = "392dbc2";
  #         sha256 =
  #           "sha256:093zapjm1z33sr7rp895kplw91qb8lq74qwc0x1ljz28xfsbp496";
  #       };
  #     });
  #   };
  #
  # services.xserver.windowManager = {
  #       awesome = {
  #         enable = true;
  #         package = inputs.nixpkgs-f2k.packages.${pkgs.system}.awesome-git;
  #
  #         luaModules = lib.attrValues {
  #           # inherit (pkgs)
  #             # lua-libpulse-glib;
  #
  #           inherit (pkgs.luaPackages)
  #             lgi
  #             ldbus
  #             luadbi-mysql
  #             luaposix;
  #         };
  #       };
  # };

  # Enable the Pantheon Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.pantheon.enable = true;
  services.xserver.desktopManager.session = [
        { name = "newm";
          start = ''start-newm & waitPID=$!'';
        }
      ];

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kurenshe = {
    isNormalUser = true;
    description = "Nurdaulet";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      firefox
      discord
      sublime4
      #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs;
    [
      git
      # newm
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      #  wget
    ];
  programs.steam.enable = true;
  programs.ssh.askPassword = "";

  services.postgresql = {
    enable = true;
  };
  virtualisation.docker.enable = true;
  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "23.05"; # Did you read the comment?

}
