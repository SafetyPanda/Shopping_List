require 'yaml'
require 'package_handler'

module Shopping_list
  Version = '0.0.1'

  def self.yaml_to_hash(file)
    hash = YAML.load_file(file)
    hash['install_software'].each { |key| Package_handler.install_software(key.delete('"')) }
    hash['remove_software'].each { |key| Package_handler.remove_software(key.delete('"')) }
    puts hash['config'].inspect
  end

  def self.output_file(file)
    puts "Outputting file: #{file}"

    yaml_to_hash(file)
  end
end
