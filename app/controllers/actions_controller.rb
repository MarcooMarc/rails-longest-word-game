require 'json'
require 'open-uri'

class ActionsController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10) * ' '
  end

  def letter_in_grid(your_word)
    new
    your_word.chars.sort.all? { |letter| @letters.include?(letter) }
  end

  def score
    @letters = params[:letters]
    @your_word = params[:your_word].upcase
    url = "https://wagon-dictionary.herokuapp.com/#{@your_word}"
    word_serialized = open(url).read
    word = JSON.parse(word_serialized)
    case
    when @your_word.length == 0 || @your_word.length > 10
      @result = 'Sorry ! your word doesn\'t have the right size !! '
    when !word['found']
      @result = 'Sorry ! Your word isn\'t from this world !'
    when letter_in_grid(@your_word)
      @result = 'Use the right letters !'
    else
      @congrats = 'Welldone !!'
    end
  end
end
