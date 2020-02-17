require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  # def score
  #   @attempt = params[:word].chars
  #   @letters_array = params[:letters].chars
  #   @boolean_array = []
  #   @check = @attempt.each { |letter| @boolen_array << letters_array.include? letter }
  #   @in_grid = @boolean_array.includes
  #   raise
  #   response = open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
  #   json = JSON.parse(response.read)
  #   english_word = json['found']
  # end

  def score
    @word = params[:word].upcase
    @word_arr = @word.chars
    # @letters_arr = params[:letters].chars
    @in_grid = @word_arr.reduce(true) { |result, letter| result && (params[:letters].include? letter) }
    if @in_grid
      url = "https://wagon-dictionary.herokuapp.com/#{@word}"
      valid_serialized = open(url).read
      @valid = JSON.parse(valid_serialized)
      if @valid["found"]
        @result = "Congratulations! #{@word} is a valid English word."
      else
        @result = "Sorry, but #{@word} does not seem to be a valid english word..."
      end
    else
      @result = "Sorry but #{@word} can't be built out of #{params[:letters]}"
    end
  end
end


