class Sea < Cell
  def name
    "SEA"
  end

  def receive_shot
    self
  end
end
