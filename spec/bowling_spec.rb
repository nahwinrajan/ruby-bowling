require 'rspec'
require_relative '../bowling'
require_relative '../error_messages'

describe Bowling do
  before do
    $stdout = StringIO.new
  end
  after(:all) do
    $stdout = STDOUT
  end

  describe "#display_score" do
    bowling = Bowling.new
    it 'should print a line for normal' do
      bowling.frames_attr_writer([[10], [9,0], [9,0], [10], [10], [10], [10], [10], [10], [10,10,10]])
      expected_score = [28, 37, 46, 76, 106, 136, 166, 196, 226, 256]
      bowling.display_score
      expect($stdout.string.chomp).to match(expected_score.to_s)
    end

    it 'should be perfect score a line' do
      bowling.frames_attr_writer([[10], [10], [10], [10], [10], [10], [10], [10], [10], [10,10,10]])
      expected_score = [30, 60, 90, 120, 150, 180, 210, 240, 270, 300]
      bowling.display_score
      expect($stdout.string.chomp).to match(expected_score.to_s)
    end
  end
end
