class Sunk < Cell
  @name = "SUNK"

  def receive_shot
    # TODO maybe it's better to raise an Eroor, and handle it on the Controller
    self
  end

  def to_json(builder : JSON::Builder)
    @name.to_json
  end
end
