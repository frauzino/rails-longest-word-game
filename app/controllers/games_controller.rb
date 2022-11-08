require 'open-uri'

class GamesController < ApplicationController
  def new
    alphabet = ('a'..'z').to_a
    @letters = []
    10.times { @letters << alphabet.sample.capitalize }
  end

  def score
    @guess = params[:word]
    @guess_chars = params[:word].upcase.chars
    @letters = params[:grid_letters].chars
    @response = if !@guess_chars.all? { |letter| @guess_chars.count(letter) <= @letters.count(letter) }
                  'That word cannot be made from the grid'
                elsif !word_search(@guess)['found']
                  'That does not seem to be a valid english word'
                else
                  'Congratulations, great word'
                end
  end

  private

  def word_search(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = URI.open(url).read
    JSON.parse(word_serialized)
  end
end
