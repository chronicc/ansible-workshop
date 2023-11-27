class Windows
  def self.install_chocolatey(config)
    config.vm.provision "install_chocolatey",
      path: "https://chocolatey.org/install.ps1",
      privileged: true,
      run: "once",
      type: "shell"
  end

  def self.install_python(config)
    config.vm.provision "install_python",
      inline: "choco install -y python312",
      privileged: true,
      run: "once",
      type: "shell"

    config.vm.provision "create_symlink_for_python",
      inline: %Q(
        New-Item -ItemType SymbolicLink \
          -Path C:\\ProgramData\\chocolatey\\bin\\python.exe \
          -Target C:\\ProgramData\\chocolatey\\bin\\python3.12.exe
      ),
      privileged: true,
      run: "once",
      type: "shell"

    config.vm.provision "display_python_version",
      inline: "python --version",
      privileged: false,
      run: "always",
      type: "shell"
  end

  def self.change_admin_password(config, password)
    config.vm.provision "change_admin_password",
      inline: "net user Administrator #{password}",
      privileged: true,
      run: "once",
      type: "shell"
  end
end
