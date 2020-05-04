require "./spec_helper"
require "../src/board_validator.cr"

describe BoardValidator do
  # TODO this tests BoardValidator behaviour
  it "Given an empty board, when I shoot multiple cells, an error is returned" do
    # TODO extract GIVEN
    empty_board_file_name = "./empty_board.json"
    empty_board_str = json_file_to_string_matrix(empty_board_file_name)
    empty_board = Board.new(empty_board_str)

    # TODO extract WHEN
    two_shots_board_file_name = "./two_shots_board.json"
    two_shots_board_str = json_file_to_string_matrix(two_shots_board_file_name)
    two_shots_board = Board.new(two_shots_board_str)

    BoardValidator.shot_or_raise_error(empty_board, two_shots_board)
  end
end
