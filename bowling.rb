class Game
  def initialize
    @rolls = []
  end

  def roll(pins)
    @rolls << pins
  end

  def strike?(frame)
    frame[0] == 10
  end

  def spare?(frame)
    frame[0] + frame[1] == 10
  end

  def score
    frames = @rolls.each_cons(2)
    score = 0

    loop do
      frame = frames.next

      if strike?(frame)
        score += 10 + frame[1] + frames.peek[1]
      elsif spare?(frame)
        score += 10 + frames.peek[1]
        frames.next
      else
        score += frame[0] + frame[1]
        frames.next
      end
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

  specify "a gutter ball game" do
    20.times { subject.roll(0) }
    subject.score.should eq(0)
  end

  specify "a game of all ones" do
    20.times { subject.roll(1) }
    subject.score.should eq(20)
  end

  specify "a game with a spare" do
    roll_spare
    subject.roll(3)
    17.times { subject.roll(0) }
    subject.score.should eq(16)
  end

  specify "a game with a strike" do
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
