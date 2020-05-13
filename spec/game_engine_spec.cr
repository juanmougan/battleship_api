require "spec"
require "../src/game_engine.cr"
require "../src/board.cr"
require "./game_spec_helper.cr"

describe "#valid_move?" do
  it "given an valid move, when validate move, then return true" do
    first = empty_board
    # second = empty_board_except_by([Sea.new, Sea.new])
    second = one_shot
    GameEngine.valid_move?(first, second).should eq(true)
  end

  it "given an invalid move, when validate move, then return false" do
    first = empty_board
    # second = empty_board_except_by([Sea.new, Sea.new])
    second = two_shots
    GameEngine.valid_move?(first, second).should eq(false)
  end
end
