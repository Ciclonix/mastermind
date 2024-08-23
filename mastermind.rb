# frozen_string_literal: true

def randomNumberSequence
  return Array.new(4) { rand(1, 7) }
end

def getInputSequence
  puts "Try a combination:"
  begin
    player_try = gets.chomp.split("").map { |x| Integer(x) }
    raise ArgumentError if player_try.size != 4 || player_try.min < 1 || player_try.max > 6
  rescue ArgumentError
    puts "Error: Invalid combination"
    retry
  end
end