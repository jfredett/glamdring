# TODO: Probably extract this to yet another flake, all the users can be defined right in
# flake.nix, along with ssh-key, can automate uploading the key to vault from there, etc.
{ pkgs, lib, ... }: let
  inherit (pkgs) stdenv;
in lib.mkIf stdenv.isLinux {
  # TODO: Make this a proper module, allow turning on/off common users from there.

  # FIXME: I don't want to include a hashed password, I don't have a nixos-based
  # dev environment yet, so I'm stuck in a bootstrapping problem. This should
  # eventually be replaced with some secure way of doing this, probably LDAP.
  security.sudo.wheelNeedsPassword = false;

  users.users = {
    # this is me
    jfredett = {
      isSystemUser = false;
      isNormalUser = true;
      group = "jfredett";
      extraGroups = [ "wheel" "libvirtd" ];
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDoqUmaFuk8Zcf+ngwc9joUJsFrcOy4Bm/xQ2cs3Q7LfeCRvo2TcnpH0oK3wJJBYYmVRf76DG08vI76x4vT9DD9CbD2otDQi8NTlncRMkSYkthzd8AWea4P7i4ZZ8WVJQgBGhDkVseVUIDjrVN3BC0S0ULNiKvP3nLs358W7hmQJg1FsbTmxDTccN2cLqNdnbnCc/aYGYQtxBAcaq+CqkJT9TAM+snearOuBzhcUVZf/uDrpuanQbkBJpatbMn63fvPTGlalb8XSpDeG0TAb9rMRLkLbKuuFl/yJHhVv3Q0VJVnMQuK21GJdXN26N6qPOqDJ2ehJhtVYdFJrnfBGcdpMf8hvIIPynnVM65FRjDmnZnh1eqMFvKHnBvk8JXR1VOYXCKr6WPB9uuJNT70rHOZD1/zAz9XZczsEcW4OlVTzA0JUR8F2V5rC1V4AOyXbsHgr1/h9BNLz/T41Duzor/6nvtYuS42oZBblvo0IAmYfSFr8Lhh625fxSveQ0tccL0= jfredett@emerald.city"
      ];
    };
    # this is a user for building stuff
    builder = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGzQRvApnQP6JnsggKyQt2LUgESmbWmTBJoR3oAV4dH9ftKG7mNHeUkYpsl1qLub7MdTyv50vlIAmck5CuXfbmOzSVFO6LORxYtbxBbRYd+EPOYaltU4ZARj6RfMej36KUxmWQCmKV2mXIrU5YO+xNHBu8bArdo4hXiJGlDGdV8OdAZWTc8ppRFFmJhw78Lkm8n/ZHPGIrIxb4/6lV0BrIo3NkawNWEqtkNfBmOCr8tAnuJDRtjkreXj9DI4eUxU6QAy1rvUYgvsJDXV1gq2y/HES5wUr+HbzKRoCojfqmoTo1cedJgLNLMlfKAgUcAXTQsJBr7r7qA9Hh/e+laOLHUx91JOPOzoCwtU2WEs9ODAzQVbHwn59fP6M9yYdjjcNrR4Tl+jvIMOIe9HDYMQ6n/7En3+s/BQvH7WO71SBV15iobN7jGCbjrjhFcL4A6vK2bp/PA93Lid7NSfjfKSSAr+jGIJshalYDaQUIECbko33eUU6iV4tvBgzkzzpG+Gc= builder@ereshkigal"
      ];
    };
  };

  users.groups.jfredett = {};

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  networking.firewall.allowedTCPPorts = lib.mkIf stdenv.isLinux [ 22 ];
}
