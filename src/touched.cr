class Touched < Cell
  def name
    "TOUCHED"
  end

  def receive_shot
    Sunk.new
  end

  # def to_json(builder : JSON::Builder)
  #   @name.to_json
  # end
end
