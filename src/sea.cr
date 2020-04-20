class Sea < Cell
  def name
    "SEA"
  end

  def receive_shot
    self
  end

  # def to_json(builder : JSON::Builder)
  #   puts "Sea will serialize to: #{@name.to_json}"
  #   @name.to_json
  # end
end
