let
  yakimant = [
    "age1yubikey1qfedhpwa0jdnflnvkyw0au3r2slh68wqyna6mzjee4206a6vp0xqshlr8r3"
    "age1yubikey1qfp23hg0l5t5fgtac4hrfz9dk9mjrfvjuujhhelxkwh3309hej8ju0cytuh"
  ];

  qnap = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPsHtmRlKCqa8n8p/KVJJ5GOJQccpjnlbkecqhqi5086";
  thinkpad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICEGpYbcECL6aRWEpGZLKcGwlR3Fuejf9XiXrh/NHMeD";
  validator = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFpXAqAALOropAbctZP545fRnrfWB9fOelFtG8mzxV/G";
  monitoring = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO4j48vE6jFRj/iPC271T47cBAE0R8ENW7YSviLwodya";
  linux = [ qnap thinkpad validator ];
in
{
  "service/tailscale/qnap.age" = { publicKeys = yakimant ++ [ qnap ]; };
  "service/tailscale/thinkpad.age" = { publicKeys = yakimant ++ [ thinkpad ]; };
  "service/tailscale/validator.age" = { publicKeys = yakimant ++ [ validator ]; };
  "service/tailscale/monitoring.age" = { publicKeys = yakimant ++ [ monitoring ]; };
  "service/reth/authrpc-jwt.age" = { publicKeys = yakimant ++ [ validator ]; };
  "users/yakimant/pass-hash.age" = { publicKeys = yakimant ++ linux; };
}
