require 'colorize'
require_relative 'mastermind_game'

class MasterRunner
  def initialize(game)
    @game = game
    @winner = false
    @play_history = ""
    @insults = ["I see you’ve set aside this special time to humiliate yourself in public.",
"The fact that no one understands you doesn’t mean you’re an artist.",
"I don’t know what your problem is, but I bet it’s hard to pronounce.",
"Any connection between your reality and mine is purely coincidental.",
"I’m not being rude. You’re just insignificant.",
"I like you. You remind me of when I was young and stupid.",
"You sound reasonable…Time to up my medication.",
"You are validating my inherent mistrust of strangers.",
"I’m already visualizing the duct tape over your mouth.",
"I will always cherish the initial misconceptions I had about you.",
"I’ll try being nicer if you’ll try being smarter.",
"It may be that your whole purpose in life is simply to serve as a warning to others.",
"I can’t believe that out of 100,000 sperm, you were the quickest.",
"Now we know why some animals eat their own children.",
"I’m busy now. Can I ignore you some other time?",
"Anyone who told you to be yourself couldn’t have given you any worse advice.",
"Are you always this stupid or are you making a special effort today?",
"I don’t know what makes you so dumb but it really works.",
"I bet you get bullied a lot.",
"I like you. People say I’ve got no taste, but I like you. Just kidding, I hate you.",
"I realize you have an inferiority complex but it’s fully justified."]

  end

  def colorize_pegs(peg_array)
    output1 = ""
    output2 = ""
    for i in 0..peg_array.size-1
      case peg_array[i]
      when "R"
        output1 += "/\\   ".light_red
        output2 += "\\/   ".light_red
      when "G"
        output1 += "/\\   ".light_green
        output2 += "\\/   ".light_green
      when "Y"
        output1 += "/\\   ".light_yellow
        output2 += "\\/   ".light_yellow
      when "B"
        output1 += "/\\   ".light_blue
        output2 += "\\/   ".light_blue
      end
    end
    return output1 + "\n" + output2
  end

  def get_valid_input
    valid = false
    until(valid)
      input = @game.translate_guess(gets.chomp)
      if input.count == 6
        valid = true
      else
        puts "Oops, you need 6 pegs!"
      end
    end
    return input
  end

  def play_turn()
    puts "\nYou have #{11-@game.turn_counter} turns remaining\n(B = blue, Y = Yellow, R = Red, G = Green)"
    input = get_valid_input()
    red, white = @game.compare(input)
    puts "Your guess:\n\n"
    print @play_history
    output = colorize_pegs(input) + "√".green*red + "o".yellow*white + "\n----------------------------\n"
    puts output 
    @play_history = @play_history + output
    puts "\n#{red} right color, right place".green + "\n" + "#{white} right color, wrong place \n".yellow
    if red == 6
      puts "\nMaster:\nNOOOO, you defeated me! YOU are the true master mind!"
      @winner=true
    else
      puts "Master:\n"
      puts @insults.sample
      puts "\n"
    end
    @game.turn_counter += 1
    puts "-----------------------------------------------"
  end

  def run_game()
    puts "Master:\nMwahahahaha, so you mortals seek to challenge my mind! Hah, you haven't got a chance! You have 10 guesses to crack my code but only because you'll have to give up eventually! Nyhehehe."

    puts"\nThe master has challenged you to guess his code of 6 colours. Can you crack his code?" 
    @game.summon_the_master()
    until @winner || @game.turn_counter > 10 do
      play_turn()
    end
    puts "Fools, you mortals shall never gain my master mind." if !@winner
    print "My code was :\n#{colorize_pegs(@game.solution)}\n"
  end
end

master = Master.new()
fun_times= MasterRunner.new(master)

fun_times.run_game()