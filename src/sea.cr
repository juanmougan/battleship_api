class Sea < Cell
  @name = "SEA"

  def receive_shot
    self
  end

  def to_json(builder : JSON::Builder)
    @name.to_json
  end
end
