
class MasterMind

  def check_code(guess)
    pegs = Hash[red: 0, white: 0]
    if guess[0] == @code[0]
      pegs[:red] += 1
      @red_bank[:zero] = guess[0]
      @red_bank[:one] = guess[1]
      @red_bank[:two] = guess[2]
      @red_bank[:three] = guess[3]
    elsif guess[0] == @code[1] || guess[0] == @code[2] || guess[0] == @code[3] 
      pegs[:white] += 1
      @white_bank.push(guess[0])
    end
    if guess[1] == @code[1]
      pegs[:red] += 1
      @red_bank[:zero] = guess[0]
      @red_bank[:one] = guess[1]
      @red_bank[:two] = guess[2]
      @red_bank[:three] = guess[3]
    elsif guess[1] == @code[0] || guess[1] == @code[2] || guess[1] == @code[3]
      pegs[:white] += 1
      @white_bank.push(guess[0])
    end
    if guess[2] == @code[2]
      pegs[:red] += 1 
      @red_bank[:zero] = guess[0]
      @red_bank[:one] = guess[1]
      @red_bank[:two] = guess[2]
      @red_bank[:three] = guess[3]
    elsif guess[2] == @code[0] || guess[2] == @code[1] || guess[2] == @code[3]
      pegs[:white] += 1
      @white_bank.push(guess[2])
    end
    if guess[3] == @code[3]
      pegs[:red] += 1
      @red_bank[:zero] = guess[0]
      @red_bank[:one] = guess[1]
      @red_bank[:two] = guess[2]
      @red_bank[:three] = guess[3]
    elsif guess[3] == @code[0] || guess[3] == @code[1] || guess[3] == @code[2]
        pegs[:white] += 1
        @white_bank.push(guess[3])
    end
    if pegs[:white] == 0 && pegs[:red] == 0
      @unreusables.push(guess[0], guess[1], guess[2], guess[3])
    end
    return pegs
  end

  def check_win(guess)
    if guess == @code
      return true
    else
      return false
    end
  end

end

class CodeMaker < MasterMind
  
  def initialize
    @code = Array.new(4) { rand(1...7) }
    @red_bank = Hash.new
    @white_bank = Array.new
    @unreusables = Array.new

  end

  def code_test
     @code
  end

end

class CodeBreaker < MasterMind

  def initialize(code)
    @code = code
    @red_bank = Hash.new
    @white_bank = Array.new
    @unreusables = Array.new
  end

  def guess_code
    guess = Array.new(4) { rand(1...7)}
    guess.map! { |k, v| 
       while @unreusables.include?(k)
        k = rand(1...7)
       end
       k
    }
    print "computer guesses: #{guess}"
    return guess
  end

  def code_test
    @code
  end

end

player_score = 0
computer_score = 0
player_round = "breaker"
game_state = "on"

while game_state == "on"
  while player_round == "breaker"
    maker = CodeMaker.new
    puts "current score: player: #{player_score} | computer: #{computer_score}"
    puts "player's turn to guess the code."
    guess_count = 1
    while guess_count
      guess = Array.new(4)
      puts "enter first position of guess 1-6: "
      guess[0] = gets.chomp.to_i
      puts "enter second position of guess 1-6: "
      guess[1] = gets.chomp.to_i
      puts "enter third position of guess 1-6: "
      guess[2] = gets.chomp.to_i
      puts "enter fourth position of guess 1-6: "
      guess[3] = gets.chomp.to_i
      print "player guesses: #{guess}"
      puts maker.check_code(guess)
      if maker.check_win(guess)
        player_score +=1
        puts "player has guessed correctly in #{guess_count} moves!"
        player_round = "maker"
        break
      end
      guess_count += 1
      if guess_count == 12
        computer_score +=1
        puts "player has failed to guess the code: #{maker.code_test}"
        player_round = "maker"
        break
      end
    end
  end
  
  while player_round == "maker"
    puts "current score: player: #{player_score} | computer: #{computer_score}"
    puts "computer's turn to guess the code."
    code = Array.new(4)
    puts "enter first position of code 1-6: "
    code[0] = gets.chomp.to_i
    puts "enter second position of code 1-6: "
    code[1] = gets.chomp.to_i
    puts "enter third position of code 1-6: "
    code[2] = gets.chomp.to_i
    puts "enter fourth position of code 1-6: "
    code[3] = gets.chomp.to_i
    breaker = CodeBreaker.new(code)
    guess_count = 1
    while guess_count
      guess = breaker.guess_code
      if guess == code
        computer_score += 1
        puts "computer has guessed correctly in #{guess_count} tries."
        player_round = "breaker"
        break
      end
      puts breaker.check_code(guess)
      guess_count += 1
      if guess_count == 12
        player_score += 1
        puts "computer has failed."
        player_round = "breaker"
        break
      end
    end
  end
end