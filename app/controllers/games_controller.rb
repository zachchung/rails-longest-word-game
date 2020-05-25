require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    # Pass @letters to view "/new" as instance variable
    @letters = (1..10).map { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters]
    # raise

    @result = result
  end

  def result
    if included?(@word, @letters)
      # ["D", "M", "W", "Q", "W", "E", "Q", "W", "G"]
      if english_word?(@word)
        # Method 1: display logic at controller:
        "Congrats! #{@word} is a valid English word!"
      else
        "Sorry but #{@word} does not seem to be a valid English word"
      end
    else
      # Method 2: display logic at view (<strong>)
      'not in grid'
      # @result = "Sorry but #{@word} can't be built out of #{@letters}"
    end
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end

# def score
#   # raise
#   if included?(params[:word].upcase, params[:letters])
#     # ["D", "M", "W", "Q", "W", "E", "Q", "W", "G"]
#     if english_word?(params[:word])
#       @result = "Congrats! #{params[:word].upcase} is a valid English word!"
#     else
#       @result = "Sorry but #{params[:word].upcase} does not seem to be a valid English word"
#     end
#   else
#     @result = "Sorry but #{params[:word].upcase} can't be built out of #{params[:letters]}"
#   end
# end
