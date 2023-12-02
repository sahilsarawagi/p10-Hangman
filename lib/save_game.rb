require 'yaml'
class Save
  def initialize(object)
    @obj = object
    @save_file_name = ""
    enter_file_name
    serialize_object
  end
  def enter_file_name
    puts "Please enter the file name with you want to save your game"
    @save_file_name = gets.chomp
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




