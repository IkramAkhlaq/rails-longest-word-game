require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @alphabet = ('A' ..'Z').to_a
    @grid = []
    9.times do
      @grid << @alphabet.sample
    end
  @grid
  end

def included?(attempt, grid)
@attempt = params[:Attempt].upcase
@grid = params[:grid]
  @attempt.chars.all? do |letter|
      @attempt.chars.count(letter) <= @grid.chars.count(letter)
    end
end

def english_word?(attempt)
  @attempt = params[:Attempt]
  response = open("https://wagon-dictionary.herokuapp.com/#{@attempt}")
  json = JSON.parse(response.read)
  return json['found']
end

  def score
    @attempt = params[:Attempt]
    if included?(@attempt, @grid)
      if english_word?(@attempt)
        @message = "Great, that's an english word"
        @points = @attempt.length
      else
        @message = "Bad luck, that's not an english word"
        @points = 0
      end
    else
      @message = "thats not in the grid"
      @points = 0
    end
  @score = "Points: #{@points}, Message: #{@message}"
  end
end

# def time_taken(start_time, end_time)
#   time_taken = end_time - start_time
# end

# def compute_score(attempt, time_taken)
#   time_taken > 60.0 ? 0 : params[:attempt].size / time_taken
# end



#   score_and_message = score_and_message(attempt, grid, result[:time])
#   result[:score] = score_and_message.first
#   result[:message] = score_and_message.last

#   result
# end

# def score_and_message(attempt, grid, time)
#   if included?(attempt.upcase, grid)
#     if english_word?(attempt)
#       score = compute_score(attempt, time)
#       [score, "well done"]
#     else
#       [0, "not an english word"]
#     end
#   else
#     [0, "not in the grid"]
#   end
# end


#INTERFACE

# require_relative "longest_word"

# puts "******** Welcome to the longest word-game!********"
# puts "Here is your grid:"
# grid = generate_grid(9)
# puts grid.join(" ")
# puts "*****************************************************"

# puts "What's your best shot?"
# start_time = Time.now
# attempt = gets.chomp
# end_time = Time.now

# puts "******** Now your result ********"

# result = run_game(attempt, grid, start_time, end_time)

# puts "Your word: #{attempt}"
# puts "Time Taken to answer: #{result[:time]}"
# puts "Your score: #{result[:score]}"
# puts "Message: #{result[:message]}"

# puts "*****************************************************"
