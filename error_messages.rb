class ErrorMessages
  attr_reader :INVALID_FRAMES, :INVALID_FRAMES_NOT_ARRAY, :INVALID_FRAMES_SIZE,
    :INVALID_FRAME_NOT_NUMERIC, :INVALID_FRAME_VALUE,
    :INVALID_FRAME_SIZE_LAST, :INVALID_FRAME_SCORE_STRIKE,
    :INVALID_FRAME_SCORE, :INVALID_FRAME_SCORE_SUM

  def initialize
    @INVALID_FRAMES = 'invalid frames inputted'
    @INVALID_FRAMES_NOT_ARRAY = 'entered input is not an array'
    @INVALID_FRAMES_SIZE = 'entered input must have 10 frames'

    @INVALID_FRAME_NOT_NUMERIC = 'each frame score must be numeric'
    @INVALID_FRAME_VALUE = 'each frame score must be within 0 to 10'
    @INVALID_FRAME_SIZE_LAST = 'frame 10 must consist of 3 values'
    @INVALID_FRAME_SCORE = 'invalid scoring, frame 1 - 9 must consist of 2 score'
    @INVALID_FRAME_SCORE_STRIKE = 'invalid scoring, can only have 1 score for strike in frame 1 - 9'

    @INVALID_FRAME_SCORE_SUM = 'invalid scoring, each frame score summary should not exceed 10'
  end
end
