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

def giveFeedback(original, try)
  temp_og = original.clone
  temp_try = try.clone
  black = white = 0
  temp_try.each_with_index do |num, idx|
    if num == original[idx]
      black += 1
      temp_og[idx] = temp_try[idx] = nil
    end
  end
  temp_try.each do |num|
    if !num.nil? && temp_og.include?(num)
      white += 1
      temp_og[temp_og.index(num)] = nil
    end
  end
end
