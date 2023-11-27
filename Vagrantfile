Vagrant.require_version ">= 2.4.0"
require_relative './vagrant_ext/linux'
require_relative './vagrant_ext/windows'

Vagrant.configure('2') do |config|
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = false
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = false

  config.vagrant.plugins = [
    'vagrant-hostmanager',
    'vagrant-libvirt',
  ]

  nodes = YAML.load_file('vagrant_ext/nodes.yml') || {}
  nodes.each do |node|
    config.vm.define node['name'], autostart: false do |host|
      host.vm.box = node['box']
      host.vm.box_version = node['box_version'] if node['box_version']
      host.vm.hostname = node['name']
      host.vm.network 'private_network', ip: node['ip'] if node['ip']

      if node["guest"] == "linux"
        Linux.authorize_key_for_root config, ENV['SSH_PUBLIC_KEY_PATH'] || "~/.ssh/id_rsa.pub"
      end

      if node["guest"] == "windows"
        host.winrm.max_tries = 600
        host.winrm.retry_delay = 1
        host.vm.guest = :windows
        Windows.change_admin_password host, "W0rksh0p!"
        Windows.install_chocolatey host
        Windows.install_python host
      end

      host.vm.provider :libvirt do |libvirt|
        libvirt.cpus = ENV["LIBVIRT_CPUS"] || 2
        libvirt.memory = ENV["LIBVIRT_MEMORY"] || 4096
      end
    end
  end
end
