require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ("A".."Z").to_a.sample(10)
  end

  def score
    @letters = params[:letters].split(" ")
    @word = params[:word].upcase
    @result = "Congratulations #{@word} is a valid English word!"
    valid_letters = true

    validate_letters = validate_letters(@word, @letters)
    if validate_letters
      validate_word = validate_word(@word)
      unless validate_word
        @result = "#{@word} is not in the English dictionary"
      end
    else
      @result = "#{params[:letters]} does not contain #{@word}"
    end
  end

  private

  def validate_letters(word, letters)
    word.each_char do |char|
      if letters.include? char
        letters.delete_at(letters.index(char))
      else
        return false
      end
    end
    return true
  end

  def validate_word(word)
    url ="https://wagon-dictionary.herokuapp.com/#{word}"
    json_string = open(url).read
    json_hash = JSON.parse(json_string)
    return json_hash["found"]
  end

end
