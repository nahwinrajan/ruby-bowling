require 'rspec'
require_relative '../helper/helper'
require_relative '../error_messages'

describe Helper do
  before do
    $stdout = StringIO.new
  end
  after(:all) do
    $stdout = STDOUT
  end

  helper = Helper.new
  ERR_MSG = ErrorMessages.new
  describe '#format_input=' do
    it 'should reject string' do
      helper.format_input('this is a string value')
      expect($stdout.string).to match(ERR_MSG.INVALID_FRAMES)
    end

    it 'should reject numeric' do
      helper.format_input('46')
      expect($stdout.string).to match(ERR_MSG.INVALID_FRAMES)
    end

    it 'should reject array of strings' do
      helper.format_input("['this', 'is', 'array', 'of', 'string']")
      expect($stdout.string).to match(ERR_MSG.INVALID_FRAMES)
    end

    it 'should reject array of numeric' do
      helper.format_input("[46, 57, 27, 58]")
      expect($stdout.string).to match(ERR_MSG.INVALID_FRAMES)
    end

    it 'should reject mixed value array of arrays' do
      helper.format_input("[['hellow world!', 'Viva la vida!!'],
      ['Value investing in growth companies'], [4,'abc'], [5,'abc'], [6,'abc'],
      [7,'abc'], [8,'abc'], [9,'abc'], [10,'abc']]")
      expect($stdout.string).to match(ERR_MSG.INVALID_FRAMES)
    end

    it 'should reject string array of arrays' do
      helper.format_input("[['hellow world!', 'Viva la vida!!'],
      ['Value investing in growth companies'], ['test','abc'], ['test','abc'], ['test','abc'],
      ['test','abc'], ['test','abc'], ['test','abc'], ['test','abc']]")
      expect($stdout.string).to match(ERR_MSG.INVALID_FRAMES)
    end

    it 'should reject array.size != 10' do
      helper.format_input("[[6,2],[9,1],[1,8],[10],[4,1],[5,2],[0,3],[10]")
      expect($stdout.string).to match(ERR_MSG.INVALID_FRAMES)
    end

    it 'should accept numeric array of arrays' do
      helper.format_input("[[6,2],[9,1],[1,8],[10],[4,1],[5,2],[0,3],[10],[7,0],[10,7,2]]")
      expect($stdout.string).to match('')
    end
  end

  describe '#frames_is_valid=' do
    it 'should reject non numeric array of array' do
      helper.frames_is_valid([6, 5, 4, 3, 2, 1, 46, 57])
      expect($stdout.string).to match(ERR_MSG.INVALID_FRAMES)
    end

    it 'should reject non nil value in internal array' do
      helper.frames_is_valid([[6,2],[9,1],nil,[10],[4,1],[5,2],[0,3],[10],[7,0],[10,7,2]])
      expect($stdout.string).to match(ERR_MSG.INVALID_FRAMES)
    end

    it 'last frame must consist of 3 scores' do
      helper.frames_is_valid([[6,2],[9,1],[1,8],[10],[4,1],[5,2],[0,3],[10],[7,0],[10]])
      expect($stdout.string).to match(ERR_MSG.INVALID_FRAME_SIZE_LAST)
    end

    it 'should reject non last frame with strike and spare' do
      helper.frames_is_valid([[6,2],[9,1],[10, 2],[10],[4,1],[5,2],[0,3],[10],[7,0],[10,7,2]])
      expect($stdout.string).to match(ERR_MSG.INVALID_FRAME_SCORE_STRIKE)
    end

    it 'should reject non last frame with only 1 score for spare' do
      helper.frames_is_valid([[6,2],[9,1],[2, ],[10],[4,1],[5,2],[0,3],[10],[7,0],[10,7,2]])
      expect($stdout.string).to match(ERR_MSG.INVALID_FRAME_SCORE)
    end

    it 'sum value for spare should not over 10' do
      helper.frames_is_valid([[6,2],[9,1],[2,9],[10],[4,1],[5,2],[0,3],[10],[7,0],[10,7,2]])
      expect($stdout.string).to match(ERR_MSG.INVALID_FRAME_SCORE_SUM)
    end

    it 'each value must be numeric' do
      helper.frames_is_valid([[6,2],[9,'a'],[2, 'string'],['test'],[4,1],[5,2],[0,3],[10],[7,0],[10,7,2]])
      expect($stdout.string).to match(ERR_MSG.INVALID_FRAME_NOT_NUMERIC)
    end

    it 'each score value must between 0 - 10' do
      helper.frames_is_valid([[6,2],[9,1],[2,21],[10],[-4,1],[11,2],[0,3],[10],[7,0],[10,7,2]])
      expect($stdout.string).to match(ERR_MSG.INVALID_FRAME_SCORE_SUM)
    end
  end
end
