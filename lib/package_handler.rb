#
# Handles installation and removal of Applications using a package manager.
# TODO: Add support for other package managers and maybe compilation...?
#

module Package_handler
    def self.install_software(name)
       cmd = make_command('i') + "-y #{name}"
       system(cmd)
       test_software(name)
    end

    def self.remove_software(name) 
        cmd = make_command('r') + "-y #{name}"
        system(cmd)
    end

    def self.test_software(name)
        system(name)
    end

    def self.make_command(arg)
        if get_operating_system == 'linux'
            return make_linux_command(arg)
        end
        if get_operating_system == 'mac'
            if arg == 'i'
                return 'brew install '
            else
                return 'brew remove '
            end
        end
        if get_operating_system == 'openbsd'
            if arg == 'i'
                return 'pkg_add '
            else
                return 'pkg_delete '
            end
        end
    end

    def self.make_linux_command(arg)
        package_manager = get_linux_package_manager

        if package_manager == 'dnf'
            if arg == 'i'
                return 'dnf install '
            else
                return 'dnf remove '
            end
        elsif package_manager == 'apt'
            if arg == 'i'
                return 'apt-get install '
            else
                return 'apt-get remove '
            end
        elsif package_manager == 'pacman'
            if arg == 'i'
                return 'pacman -S '
            else
                return 'pacman -R '
            end
        elsif package_manager == 'emerge'
            if arg == 'i'
                return 'emerge '
            else
                return 'emerge -C '
            end
        end
    end

    def self.get_operating_system
        if RUBY_PLATFORM.include? "linux"
            return 'linux'
        elsif RUBY_PLATFORM.include? "darwin"
            return 'mac'
        elsif RUBY_PLATFORM.include? "openbsd"
            return 'openbsd'
        else
            puts "ERROR: I don't know how to handle this OS: #{RUBY_PLATFORM}"
            exit 1
        end
    end

    def self.get_linux_package_manager
        if File.exist?('/etc/fedora-release')
            return 'dnf'
        elsif File.exist?('/etc/debian_version')
            return 'apt'
        elsif File.exist?('/etc/arch-release')
            return 'pacman'
        elsif File.exist?('/etc/gentoo-release')
            return 'emerge'
        else
            puts "ERROR: Can't determine package manager!:"
            exit 1
        end  
    end
end