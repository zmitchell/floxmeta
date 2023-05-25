{
  # Packages
  # "version" is optional, otherwise the latest is used. Try `flox search`
  # packages.nixpkgs-flox.figlet = {};
  # packages.nixpkgs-flox.bat = { version = "0.22.1"; };

  # Aliases available when environment is active
  # shell.aliases.cat = "bat";

  # Script run upon environment activation
  # Warning: Be careful when using `${}` in shell hook.
  #          Due to conflicts with Nix language you have to escape it with '' (two single quotes)
  #          Example: ` ''${ENV_VARIABLE} `
  # shell.hook = ''
  #   echo Flox Environment | figlet
  # '';

  # Environment variables
  # environmentVariables.LANG = "en_US.UTF-8";
  packages.nixpkgs-flox.python311 = {};
  packages.nixpkgs-flox.procps = {};
  packages.nixpkgs-flox.caddy = {};
  packages.nixpkgs-flox.jq = {};
  packages.nixpkgs-flox.curl = {};
  shell.hook = ''
    trap 'pkill -f server.py; pkill -f :6600' TERM QUIT HUP INT EXIT
    bash -c '
    echo "Started proxy 6600 -> 5500"
    caddy reverse-proxy --from :6600 --to :5500 &>/dev/null &
    echo "Starting server on port 5500"
    python3 server.py >/dev/null &
    '
    '';
  }
