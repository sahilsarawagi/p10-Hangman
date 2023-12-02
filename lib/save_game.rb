require 'yaml'
class Save
  def initialize(object,save_file_name)
    @obj = object
    @save_file_name = save_file_name
    serialize_object
  end
  def serialize_object
    serializing_object = YAML.dump(@obj)
    save_to_file(serializing_object)
  end
  def save_to_file(obj)
    Dir.mkdir('saved_game') unless Dir.exist?('saved_game')
    file_name= "saved_game/#{@save_file_name}.yaml"
    File.open(file_name,'w') {|f| f.write(obj)}
  end
end




