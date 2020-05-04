require "spec"
require "../src/battleship_api"

# TODO read about this. Is this the place to put this kind of code?
def json_file_to_string_matrix(file_name)
  file_content = File.read(file_name)
  return Array(Array(String)).from_json(file_content)
end
