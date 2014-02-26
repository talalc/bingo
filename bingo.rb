# author = Talal Choudhury
# WDI February '14 Reduce
# Decided to take one of my Java projects from last semester and try it in Ruby
# I know it's not completely 'rubyist', but for now I'm happy it works
# License/Permissions: Don't share with Map! grr! lol
# Instructions:  save to some folder
#                use terminal to cd to that folder
#                then ruby bingo.rb
#                only enter integers please, no real error checking, yet
#                press Ctrl+C to force quit
# Comments: took ~ 2 hours
# 
# Version: Super Alpha Combo + headgear edition (Google Glass incompatible)
# Changes: Now Object Oriented!
#          Using .each_with_index instead of for loops
#          Reduced number of lines utilizing the ternary operator
class BingoCard
  
  def initialize
    @bingoCard = Array.new(5) {Array.new(5)}    # declare 2-dim array of numbers, thanks google = )
    @called = Array.new(5) {Array.new(5)}       # declare 2-dim array of booleans
    @roll = -1                                  # i love counters = )
    row = Array.new
    @bingoCard.each_with_index do |k, i|        # first time using each_with_index, k = subarray, i = index
      startValue = i * 15 + 1
      15.times { |n| row[n] = startValue + n }
      row.shuffle!                              # shuffle!, thanks google!
      k.each_with_index do |l, j|
        @bingoCard[i][j] = row[j]
        @called[i][j] = false
      end
    end
    @called[2][2] = true                        # free space
  end

  def print_bingo
    @roll += 1
    print "\n   B     I     N     G     O\n\n"
    @bingoCard.each_with_index do |l, j|
      l.each_with_index do |k, i|
        if @called[i][j]
          @bingoCard[i][j] < 10 ? (print " ( #{@bingoCard[i][j]}) "): (print " (#{@bingoCard[i][j]}) ")
        else
          @bingoCard[i][j] < 10 ? (print "   #{@bingoCard[i][j]}  "): (print "  #{@bingoCard[i][j]}  ")
        end
      end
      print "\n\n"
    end
    puts "roll #: #{@roll}\n\n"
  end

  def update(col,num)
    @bingoCard.each_with_index do |i, j|
      @called[col][j] = true if @bingoCard[col][j] == num
    end
  end

  def check_won
    winner = true
    @bingoCard.each_with_index do |k, i|
      k.each_with_index do |l, j|
        winner &&= @called[i][j]    # vertical check
      end
      return winner if winner
      winner = true
    end
    @bingoCard.each_with_index do |k, i|
      k.each_with_index do |l, j|
        winner &&= @called[j][i]    # horizontal check
      end
      return winner if winner
      winner = true
    end
    @bingoCard.each_with_index do |k, i|
      winner &&= @called[i][i]      # diagonal1 check
    end
    return winner if winner
    winner = true
    @bingoCard.each_with_index do |k, i|
      winner &&= @called[i][4-i]    # diagonal2 check
    end
    return winner if winner
    winner = true
    return false
  end
end

# the way i see it, the program really begins here

bingo = BingoCard.new
called_num = Array.new
random = (1..75).to_a.shuffle
won = false
system "clear"
bingo.print_bingo
puts "Called: #{called_num}\n\n"
while !won
  print "Enter a number 1-75 (or >75 for random speedplay):"
  num = gets.chomp.to_i
  num % 15 == 0 ? column = num / 15 - 1: column = num / 15
  break if num > 75
  system "clear"
  called_num.push(num)
  bingo.update(column,num)
  bingo.print_bingo
  puts "Called: #{called_num}\n\n"
  if bingo.check_won
  	puts "\tYou Won!\n\n"
  	won = true
  end
end
# in case you picked the random option ( > 75 )
while !won
  num = random.pop
  num % 15 == 0 ? column = num / 15 - 1: column = num / 15
  system "clear"
  called_num.push(num)
  bingo.update(column,num)
  bingo.print_bingo
  puts "Called: #{called_num}\n\n"
  if bingo.check_won
  	puts "\tYou Won!\n\n"
  	won = true
  end
end