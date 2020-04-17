abstract class Cell
  abstract def receive_shot

  def to_json(builder : JSON::Builder)
    puts "please implement me"
  end
end
