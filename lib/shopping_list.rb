require 'yaml'
require 'package_handler'

module Shopping_list
  Version = '0.0.1'

  def self.yaml_to_hash(file)
    list = YAML.load_file(file)

    software_check(list)

    
    puts list['config'].inspect
  end


  def self.software_check(list)
    if list['install_software'].nil?
      puts "No software to install!"
    else
      list['install_software'].each { |key| Package_handler.install_software(key.delete('"')) }
    end
    if list['remove_software'].nil?
      puts "No software to remove!"
    else
      list['remove_software'].each { |key| Package_handler.remove_software(key.delete('"')) }
    end
  end

  def self.output_file(file)
    puts "Outputting file: #{file}"
    yaml_to_hash(file)
  end
end
