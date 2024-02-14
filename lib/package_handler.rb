#
# Handles installation and removal of packages.
# TODO: Add support for other package managers and maybe compilation...?
#

module Package_handler
    def self.install_software(name)
        system("dnf install -y #{name}")
        test_software(name)
    end

    def self.remove_software(name)
        system("dnf remove -y #{name}")
    end

    def self.test_software(name)
        system(name)
    end
end