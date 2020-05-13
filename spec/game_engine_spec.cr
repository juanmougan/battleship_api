require "spec"
require "../src/game_engine.cr"
require "../src/board.cr"
require "./game_spec_helper.cr"

describe "#valid_move?" do
  it "returns true if a valid move is attempted" do
    first = empty_board
    # second = empty_board_except_by([Sea.new, Sea.new])
    second = one_shot
    GameEngine.valid_move?(first, second).should eq(true)
  end

  it "returns false if an invalid move is attempted" do
    first = empty_board
    # second = empty_board_except_by([Sea.new, Sea.new])
    second = two_shots
    GameEngine.valid_move?(first, second).should eq(false)
  end

  it "raises an Exception if a move is invalid" do
    begin
      GameEngine.move(empty_board, two_shots)
    rescue
      # TODO do nothing?
    else
      fail("Didn't get any Exception!")
    end
  end

  it "returns the new status of the Board if a move is valid" do
    expected_after = one_shot
    after = GameEngine.move(empty_board, expected_after)
    after.should eq(expected_after)
  end
end
