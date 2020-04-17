class Sunk < Cell
  def receive_shot
    # TODO maybe it's better to raise an Eroor, and handle it on the Controller
    self
  end
end
