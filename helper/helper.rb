require './error_messages'

class Helper
  def initialize
    @ERR_MSG = ErrorMessages.new
  end

  def format_input (unformatted_input)
    ary = unformatted_input.scan(/\d[,\d]*\d/) unless unformatted_input == nil

    if (!ary.nil? && ary.size != 10)
      print @ERR_MSG.INVALID_FRAMES
      ary = nil
    elsif (!ary.nil? && ary.size > 0)
      for i in 0..9 do
        ary[i] = ary[i].split(',')
        # another damage limitation
        for j in 0..2 do
          # ruby return nil for unused / undefined array element
          unless ary[i][j].nil?
            ary[i][j] = ary[i][j].to_i if ary[i][j].match(/\A\d+\z/)
          end
        end
      end
    end

    return ary
  end

  def frames_is_valid(new_frames)
    is_valid = false
    err_msg = ''

    #validate is array of numeric arrays
    for i in 0..9 do
      # each element of main array must be an array
      if ( new_frames[i].nil? || !new_frames[i].kind_of?(Array) )
        # p new_frames[i]
        err_msg = @ERR_MSG.INVALID_FRAMES
      # last element of main array must consist of 3 values
      elsif (i == 9 && new_frames[i].size != 3)
        err_msg = @ERR_MSG.INVALID_FRAME_SIZE_LAST
      # except for the last element in main array, should have 1 value for a strike
      elsif (i != 9 && new_frames[i][0] == 10 && new_frames[i].size != 1)
        err_msg = @ERR_MSG.INVALID_FRAME_SCORE_STRIKE
      # except for the last element in main array, should have 2 values for not a strike
      elsif (i != 9 && new_frames[i][0] != 10 && new_frames[i].size != 2)
        err_msg = @ERR_MSG.INVALID_FRAME_SCORE
      # sum of both element should be; 0 >= sum <= 10
      elsif (i != 9 && new_frames[i][0] != 10 && new_frames[i].size == 2)
        # non numeric validation is after this, so just concentrate
        # on sum value of it
        if(!new_frames[i][0].nil? && new_frames[i][0].kind_of?(Numeric))
          if(!new_frames[i][1].nil? && new_frames[i][1].kind_of?(Numeric))
            unless (new_frames[i][0] + new_frames[i][1]).between?(0,10)
              err_msg = @ERR_MSG.INVALID_FRAME_SCORE_SUM
            end
          end
        end
      end

      # do not proceed further if we already found frames is invalid
      break unless err_msg.empty?

      # value should be: 0 >= n <= 10
      for j in 0..new_frames[i].size do
        if (!new_frames[i][j].nil? && !new_frames[i][j].kind_of?(Numeric))
          err_msg = @ERR_MSG.INVALID_FRAME_NOT_NUMERIC
        elsif (!new_frames[i][j].nil? && !new_frames[i][j].between?(0,10))
           err_msg = @ERR_MSG.INVALID_FRAME_VALUE
        end
      end

      is_valid = err_msg.empty?
    end

    puts err_msg unless err_msg.empty?
    return is_valid
  end
end
