require File.expand_path(File.join(File.dirname(__FILE__), "game"))

describe Game do

  let(:game) { Game.new }

  it "has three doors" do
    expect(game.doors.size).to eq 3
  end

  it "has one prize behind each door (which is a string - to be redeemed)" do
    game.doors.each do |door|
      expect(door.prize).to_not be_nil
    end
  end

  it "only has one car behind all three doors" do
    expect(game.doors.select do |door|
      door.prize == "car"
    end.size).to eq 1
  end

  it "only has two goats behind the other doors" do
    expect(game.doors.select do |door|
      door.prize == "goat"
    end.size).to eq 2
  end

  # will fail 1/3^19 times
  it "should not always have a car behind the same door" do
    car_doors = []
    20.times do |x|
      game = Game.new
      game.doors.each_with_index { |door, index| car_doors << index if door.prize == "car" }
    end
    expect(car_doors.uniq.size).to eq 3
  end

  it "allows a player to choose a door" do
    expect(game.choose_door(2).chosen_door_number).to eq 2
  end

  it "knows the car door number" do
    expect(game.car_door_number).to be_kind_of(Integer)
  end

  it "knows if the chosen door is a winner" do
    expect(game.choose_door(game.car_door_number)).to be_winner
  end

  it "knows if the chosen door is not a winner" do
    not_the_car_door_number = (game.car_door_number + 1) % 3
    expect(game.choose_door(not_the_car_door_number)).to_not be_winner
  end

  it "should pick a goat door to show the player if the player chose the car door" do
    game.choose_door(game.car_door_number)
    game.show_contestant_a_goat
    expect(game.revealed_door_number).to_not eq game.car_door_number
  end

  describe "simulation" do
    let(:simulation) { Simulation.new }

    it "should win with a swap strategy 66% of the time and with a stay strategy 33% of the time" do
      simulation.run(10000000)
      expect(simulation.swap_win_percentage).to match(65...67)
      expect(simulation.stay_win_percentage).to match(32...34)
    end

  end

end
