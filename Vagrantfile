# Linux Network Web admin interface (lnw)

# Inspired by https://github.com/vemarsas/wiedii-bootstrap/blob/main/Vagrantfile

DEBIAN_BOX    = 'boxomatic/debian-13'
RAM_MB        = 2048
MESSAGE       = <<END
  ssh -p 2201 lnw@localhost # main lnw VM: default password: lnw
  ssh -p 2202 lnw@localhost # lnwb: a second lnw, optional, downstream VM

  cd /opt/lnw               # point your editor ssh plugin to this folder (or mount sshfs etc.)
  bash scripts/start.sh

  http://localhost:8001
  http://localhost:8002     # lnwb, optional

  # Note vagrant user (full sudoer) still active.

  You can also use VSCode remotely over SSH this way (example first VM):

  code --folder-uri "vscode-remote://ssh-remote+lnw@localhost:2201/opt/lnw"

  You might want to manually change MAC address of first ethernet to prevent conflict between VMs.
  (Virtualbox apparently does not give you control of this setting the first/default network interface).
END

def assign_ram(vmcfg, megabytes)
  vmcfg.vm.provider 'virtualbox' do |vb|
    vb.memory = megabytes
  end
end

#                +-----------------------------------+
#                |                                   |
#  Internet --- Host -(*)- LNW --- internal-a-1 -(*)- LNWb --- internal-b-1
#                           |
#                           +----- internal-a-2
#
#  (*) default gw

Vagrant.configure('2') do |config|
  config.vm.box = DEBIAN_BOX

  assign_ram                  config,   RAM_MB

  config.vm.provision         'shell',
    path: 'kickoff.sh',       # invokes setup.sh in target vm
    env:  {
      'BRANCH': ENV['BRANCH'] || ''
    }
  config.vm.provision         'file',   source: 'files/sshd_config',  destination: '/tmp/sshd_config_lnw'
  config.vm.provision         'shell',  inline: 'mv -v /tmp/sshd_config_lnw /etc/ssh/sshd_config.d/lnw.conf'
  config.vm.provision         'shell',  inline: 'chmod -x /etc/ssh/sshd_config.d/lnw.conf'
  config.vm.provision         'shell',  inline: '. /opt/lnw/scripts/setup_dev.sh'

  config.vm.post_up_message = MESSAGE

  config.vm.define 'lnw', primary: true do |lnw|
    lnw.vm.hostname = 'lnw'

    lnw.vm.network "forwarded_port", guest: 22,   host: 2201
    lnw.vm.network 'forwarded_port', guest: 8000, host: 8001

    # NIC #1 is the default NAT interface, with forwarded ports above

    # NIC #2
    lnw.vm.network 'private_network',
      auto_config: false,
      virtualbox__intnet: 'internal-a-1'

    # NIC #3
    lnw.vm.network 'private_network',
      auto_config: false,
      virtualbox__intnet: 'internal-a-2'
  end

  config.vm.define 'lnwb', autostart: false do |lnwb|
    lnwb.vm.hostname = 'lnwb'

    # NIC #1
    lnwb.vm.network "forwarded_port", guest: 22,   host: 2202
    lnwb.vm.network 'forwarded_port', guest: 8000, host: 8002

    # NIC #2  Connected to the other network appliance
    lnwb.vm.network 'private_network',
      auto_config: false,
      virtualbox__intnet: 'internal-a-1'

    # NIC #3
    lnwb.vm.network 'private_network',
      auto_config: false,
      virtualbox__intnet: 'internal-b-1'
  end
end


