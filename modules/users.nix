{
  ...
}:

{
  users.mutableUsers = false;

  users.users.yakimant = {
    isNormalUser = true;
    description = "yakimant";
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDoGVex1+pNWNMwC5dygX0WnYcythWB76c5s+M68JKsETiTNeJRbRqB5vMiaeeb0uTXdwNeic5inJkF4VDkW53o2v2+c5HbizgXB3VlxdZJDaK3eK6QfQ4QfUsvphdh5BgFTCvCj0u2Jja+lupsNg68jQirTDTyKo8nrWbYnWGGgjMDLUZ3iO3XmjGEH82izfyg4IWGum4+58hPwTfqn+sO1M6mEUgwgtgUmXPXk5W2xlrzVVNtfpUU1rCLjpdIP8dStFUczm9u9M1hYAGhH9XuqYY4L1bKyHhb20hKlujItudLxN6H7iNy3tOLFvpNRib9euhoqRKMuROtucANKRoA6HM7JvpBykbWuEHDmxWsy2CCGxaNJbsexkEqzCiULBLIxBL2KSFX0rp4BZ9VqrfwPTcl60Mh0DbRDzGAAiEnHRk9Mjz/L1enGk7Gtqso2uyi6pi7b9r/1znkKJUfSRALRMdcnm6wghSvNA/WHKCDxwKY31DUw7kKZXeyjZbbQ/8U1+84jleT8xMdAECz/lhVD2jQ5rrD8hchziXjvKcUT4lzXW8gZ5LwXLC4AJC7Wvq/Hue1HKJDTMCx82uWRPCLhO+ZbUnorsdvkFhoVN7A5QeQIWp8C6xZPGEPej/4v9l/iB2bKv6v7TTlnJrCM6CSRP2XhblsvXaGo+tjEHaKxw== yakimant@gmail.com"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILcivTJT6l2oSSKqmON+CAH8j1NwLkW7RtZkDnXfBnMv yakimant@gmail.com"
    ];
    hashedPassword = "$y$j9T$3s/rC.yqNyNobdespcGNJ/$PYrHL9yWCdEy4WsjHHXGt9edvLD/YqpVXjZKKKxbKk/";
  };

  security.sudo.wheelNeedsPassword = false;
}
