require './helper/helper.rb'
require './error_messages'

class Bowling
  attr_reader :frames

  def initialize
    @frames = []
    @score = []
  end

  def display_score
    count_frame_score
    p @score.to_s unless (@score.empty? || @score.nil?)
  end

  def frames_attr_writer(new_frames)
    helper = Helper.new
    if helper.frames_is_valid(new_frames)
      @frames.replace(new_frames)
    else
      return false
    end
  end

private
    def count_frame_score
      current_frame_score = 0
      @score = Array.new(10)
      for i in 0...@frames.size do
        current_frame_score = 0

      #   # on strike current frame also count score from next 2 throws
        if ( i == 9)
          current_frame_score = @frames[i][0] + @frames[i][1] + @frames[i][2]
        elsif (@frames[i][0] == 10)
          if (@frames[i+1].size == 1)
            current_frame_score = @frames[i][0] + @frames[i+1][0] + @frames[i+2][0]
          elsif (@frames[i+1].size >= 2)
            current_frame_score = @frames[i][0] + @frames[i+1][0] + @frames[i+1][1]
          end
        else
          current_frame_score = @frames[i][0] + @frames[i][1]
        end

        if i == 0
          @score[i] = current_frame_score
        else
          @score[i] = @score[i-1] + current_frame_score
        end
      end
    end
end
