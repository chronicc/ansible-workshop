# Ansible Workshop

Lessons for learning Ansible provided by [Kurt Thomas Steinert](https://www.linkedin.com/in/contact-steinert/).

## Getting started

1. Install vagrant version **>=2.4.0**. You can download the latest version [here](https://www.vagrantup.com/downloads.html).
2. Install libvirt on e.g. [Ubuntu](https://help.ubuntu.com/community/KVM/Installation), [ArchLinux](https://wiki.archlinux.org/title/Libvirt) or find the installation guide for your OS.
3. Run the install command.
    ```shell
    make install
    ```
4. Configure your sudo to use passwordless sudo in general or if you don't want a more secure approach add the configuration from the [Vagrant Hostmanager](README.md#vagrant-hostmanager) plugin.

## Using the vagrant virtual machines

To test your solutions from the challenges, you can use the virtual machines provided by vagrant in this repository. To see all possible virtual machines check the **name** key inside the [vagrant_ext/nodes.yml](./vagrant_ext/nodes.yml).

You can start a machine with e.g. `vagrant up ubuntu-2204`.

You can stop a machine with e.g. `vagrant destroy -f ubuntu-2204`.

## Vagrant Plugins

### Vagrant Hostmanager

Manages `/etc/hosts` file of the system to ensure virtual machines are reachable by <short-name>. To ensure every user in sudo group can update `/etc/hosts` the sudoers file needs to be modified:

```shell
# vagrant-hostmanager
Cmnd_Alias VAGRANT_HOSTMANAGER_UPDATE = /bin/cp */.vagrant.d/tmp/hosts.local /etc/hosts
%sudo ALL=(root) NOPASSWD: VAGRANT_HOSTMANAGER_UPDATE
```

If a machine was not added to the hosts file after being created, run `vagrant hostmanager` manually. Sometimes this fixes the problem.

## License

MIT
