let
  yakimant1 = "age1yubikey1qv8svrrl7grjjeh5qllgpz6wn3c85xsxu87y5hk0untqtsnr36tjxrwzt0d";
  yakimant2 = "age1yubikey1q28qjdfnktl7rdd4wk84tgt3jx30nm8m7ac4x5qcw57ujtqtzfqexkm67tf";
  yakimant = [ yakimant1 yakimant2 ];

  qnap = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPsHtmRlKCqa8n8p/KVJJ5GOJQccpjnlbkecqhqi5086";
in
{
  "service/tailscale/qnap.age" = { publicKeys = yakimant ++ [ qnap ]; };
}
