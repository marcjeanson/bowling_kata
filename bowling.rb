class Game
  def initialize
    @rolls = []
  end

  def roll(pins)
    @rolls << pins
  end

  def spare?(roll_index)
    @rolls[roll_index] + @rolls[roll_index + 1] == 10
  end

  def strike?(roll_index)
    @rolls[roll_index] == 10
  end

  def score
    score = 0
    roll_index = 0
    frame = 0
    while frame < 10
      if strike?(roll_index)
        score += 10 + @rolls[roll_index + 1] + @rolls[roll_index + 2]
        roll_index += 1
      elsif spare?(roll_index)
        score += 10 + @rolls[roll_index + 2]
        roll_index += 2
      else
        score += @rolls[roll_index] + @rolls[roll_index + 1]
        roll_index += 2
      end
      frame += 1
    end
    score
  end
end


describe Game do
  def roll_spare
    subject.roll(5)
    subject.roll(5)
  end

  def roll_strike
    subject.roll(10)
  end

  specify "a game of all gutter ball frames" do
    20.times { subject.roll(0) }
    subject.score.should eq(0)
  end

  specify "a game of all 1 point frames" do
    20.times { subject.roll(1) }
    subject.score.should eq(20)
  end

  specify "a single spare" do
    roll_spare
    subject.roll(3)
    17.times { subject.roll(0) }
    subject.score.should eq(16)
  end

  specify "a single strike" do
    roll_strike
    subject.roll(3)
    subject.roll(4)
    17.times { subject.roll(0) }
    subject.score.should eq(24)
  end

  specify "a perfect game" do
    12.times { roll_strike }
    subject.score.should eq(300)
  end
end
