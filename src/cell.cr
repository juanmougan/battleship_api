abstract class Cell
  abstract def receive_shot
  abstract def to_json(builder : JSON::Builder)
end
