# frozen_string_literal: true

class Mastermind
  def initialize
    print "Choose the code (1) or Find the code (2): "
    mode = gets.chomp
    if mode == "1"
      chooseTheCode ? puts("The computer won!") : puts("The computer lost!")
    elsif mode == "2"
      findTheCode ? puts("You win!") : puts("You lose!")
    end
  end

  def randomNumberSequence
    return Array.new(4) { rand(1..6) }
  end

  def getInputSequence(choose_code = false)
    begin
      choose_code ? print("Choose the code: ") : print("Try a combination: ")
      player_try = gets.chomp.split("").map { |x| Integer(x) }
      raise ArgumentError if player_try.size != 4 || player_try.min < 1 || player_try.max > 6
    rescue ArgumentError
      puts "Error: Invalid combination"
      retry
    end
    return player_try
  end

  def giveFeedback(original, try)
    feedback = {black: 0, white: 0}
    try.each_with_index do |num, idx|
      if num == original[idx]
        feedback[:black] += 1
        original[idx] = try[idx] = nil
      end
    end
    try.each do |num|
      if !num.nil? && original.include?(num)
        feedback[:white] += 1
        original[original.index(num)] = nil
      end
    end
    return feedback
  end

  def findTheCode
    original = randomNumberSequence
    12.times do |x|
      x == 11 ? puts("1 try left") : puts("#{12 - x} tries left")
      try = getInputSequence
      feedback = giveFeedback(original.clone, try.clone)
      return true if feedback[:black] == 4

      puts "Correct position  #{feedback[:black]}"
      puts "Wrong position    #{feedback[:white]}\n\n"
    end
    return false
  end

  def chooseTheCode
    original = getInputSequence(true)
    feedback = prev_try = nil
    try = [1, 1, 1, 1]
    idx = 0
    12.times do |x|
      x == 11 ? puts("1 try left") : puts("#{12 - x} tries left")
      puts "Trying code #{try.join}\n\n"
      feedback = giveFeedback(original.clone, try.clone)
      return true if feedback[:black] == 4

      to_increase = 4 - feedback[:black] - feedback[:white]
      if !to_increase.zero?
        to_increase.times { |x| try[try.size - x - 1] += 1 }
        prev_try = try.clone
        prev_feedback = feedback
      else
        if prev_feedback[:black] > feedback[:black]
          try = prev_try
          feedback = prev_feedback
        end
        prev_try = try.clone
        try[idx], try[idx + 1] = try[idx + 1], try[idx]
        idx += 1
        idx = 0 if idx == 4
      end
    end
    return false
  end
end


Mastermind.new
