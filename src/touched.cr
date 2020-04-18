class Touched < Cell
  @name = "TOUCHED"

  def receive_shot
    Sunk.new
  end

  def to_json(builder : JSON::Builder)
    @name.to_json
  end
end
