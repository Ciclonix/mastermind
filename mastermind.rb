# frozen_string_literal: true

class Mastermind
  def initialize
    play ? puts("You win!") : puts("You lose!")
  end

  def randomNumberSequence
    return Array.new(4) { rand(1..6) }
  end

  def getInputSequence
    begin
      print "Try a combination: "
      player_try = gets.chomp.split("").map { |x| Integer(x) }
      raise ArgumentError if player_try.size != 4 || player_try.min < 1 || player_try.max > 6
    rescue ArgumentError
      puts "Error: Invalid combination"
      retry
    end
    return player_try
  end

  def giveFeedback(original, try)
    temp_og = original.clone
    temp_try = try.clone
    feedback = {black: 0, white: 0}
    temp_try.each_with_index do |num, idx|
      if num == original[idx]
        feedback[:black] += 1
        temp_og[idx] = temp_try[idx] = nil
      end
    end
    temp_try.each do |num|
      if !num.nil? && temp_og.include?(num)
        feedback[:white] += 1
        temp_og[temp_og.index(num)] = nil
      end
    end
    return feedback
  end

  def play
    original = randomNumberSequence
    12.times do |x|
      x == 11 ? puts("1 try left") : puts("#{12 - x} tries left")
      try = getInputSequence
      feedback = giveFeedback(original, try)
      return true if feedback[:black] == 4

      puts "Correct position  #{feedback[:black]}"
      puts "Wrong position    #{feedback[:white]}\n\n"
    end
    return false
  end
end