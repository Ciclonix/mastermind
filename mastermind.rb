# frozen_string_literal: true

class Mastermind
  def initialize
    puts "The codes are 4 characters long and each from 1 to 6"
    print "Want to play Choose the code (1) or Find the code (2)? "
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
    original = original.clone
    try = try.clone
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
      feedback = giveFeedback(original, try)
      return true if feedback[:black] == 4

      puts "Correct position  #{feedback[:black]}"
      puts "Wrong position    #{feedback[:white]}\n\n"
    end
    return false
  end

  def chooseTheCode
    original = getInputSequence(true)
    possible = (1..6).to_a.permutation(4).to_a
    try = [1, 1, 2, 2]
    12.times do |tries|
      tries == 11 ? puts("1 try left") : puts("#{12 - tries} tries left")
      puts "Trying code #{try.join}\n\n"
      feedback = giveFeedback(original, try)
      return true if feedback[:black] == 4

      possible.each do |code|
        temp_feedback = giveFeedback(try, code)
        possible.delete(code) if code == try || temp_feedback != feedback
      end
      try = possible.sample
    end
    return false
  end
end


Mastermind.new
