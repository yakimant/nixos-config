let
  yakimant = [
    "age1yubikey1qv8svrrl7grjjeh5qllgpz6wn3c85xsxu87y5hk0untqtsnr36tjxrwzt0d"
    "age1yubikey1q28qjdfnktl7rdd4wk84tgt3jx30nm8m7ac4x5qcw57ujtqtzfqexkm67tf"
  ];
  users = yakimant;

  qnap = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPsHtmRlKCqa8n8p/KVJJ5GOJQccpjnlbkecqhqi5086";
  thinkpad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICEGpYbcECL6aRWEpGZLKcGwlR3Fuejf9XiXrh/NHMeD";
  linux = [ qnap thinkpad ];
in
{
  "service/tailscale/qnap.age" = { publicKeys = yakimant ++ [ qnap ]; };
  "service/tailscale/thinkpad.age" = { publicKeys = yakimant ++ [ thinkpad ]; };
  "users/yakimant/pass-hash.age" = { publicKeys = yakimant ++ linux; };
}
