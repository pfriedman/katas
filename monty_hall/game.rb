class Game

  attr_accessor :doors, :chosen_door_number, :revealed_door_number

  def initialize
    @doors = prizes.map { |prize| Door.new(prize) }.shuffle
  end

  def choose_door(n)
    @chosen_door_number = n
    self
  end

  def winner?
    chosen_door_number == car_door_number
  end

  def show_contestant_a_goat
    @revealed_door_number = ([0...@doors.size] - [car_door_number, chosen_door_number]).sample
  end

  def car_door_number
    @doors.index { |door| door.prize == "car" }
  end

  private

    def prizes
      %w(car goat goat)
    end

end

class Door

  attr_accessor :prize

  def initialize(prize)
    @prize = prize
  end
end

class Simulation

  attr_accessor :swap_win_count
  attr_accessor :stay_win_count

  def run(number_of_games)
    @stay_win_count = 0
    @swap_win_count = 0
    number_of_games.times do
      game = Game.new
      game.choose_door(rand(3))
      if game.winner?
        @stay_win_count += 1
      else
        @swap_win_count += 1
      end
    end
  end

  def swap_win_percentage
    (@swap_win_count.to_f / total) * 100
  end

  def stay_win_percentage
    100 - swap_win_percentage
  end

  def total
    @stay_win_count + @swap_win_count
  end
end
