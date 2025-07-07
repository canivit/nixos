{
  lib,
  config,
  ...
}:
let
  cfg = config.modules.networking.wireguard;
in
{
  options.modules.networking.wireguard = {
    enable = lib.mkEnableOption "enable wireguard vpn";
  };

  config = lib.mkIf cfg.enable {
    networking.wg-quick.interfaces.wg0 = {
      address = [ "10.2.0.2/32" ];
      dns = [ "10.2.0.1" ];
      privateKeyFile = "/run/secrets/wireguard_private_key";
      peers = [
        {
          publicKey = "bXiKQCzCfajtuTNSQQpAqcrO0Rhid5d6E3MseL2lxXU=";
          allowedIPs = [
            "0.0.0.0/0"
            "::/0"
          ]; # route everything
          endpoint = "149.22.80.28:51820";
          persistentKeepalive = 25;
        }
      ];

      postUp = ''
        # Allow all outgoing traffic via wg0
        iptables -A OUTPUT -o wg0 -j ACCEPT

        # Allow established traffic
        iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

        # Allow SSH regardless of interface
        iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT
        iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

        # Drop all other outgoing traffic
        iptables -A OUTPUT -j DROP
      '';

      postDown = ''
        iptables -D OUTPUT -o wg0 -j ACCEPT

        iptables -D OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

        iptables -D OUTPUT -p tcp --dport 22 -j ACCEPT
        iptables -D OUTPUT -p tcp --sport 22 -j ACCEPT

        iptables -D OUTPUT -j DROP
      '';
    };
  };
}
