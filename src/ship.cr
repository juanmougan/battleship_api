class Ship < Cell
  def name
    "SEA"
  end

  def receive_shot
    Touched.new
  end

  def to_json(builder : JSON::Builder)
    @name.to_json
  end
end
