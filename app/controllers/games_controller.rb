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

    @word.each_char.with_index do |char, index|
      if @letters.include? char
        @letters.slice!(index, 1)
      else
        @result = "#{params[:letters]} does not contain #{@word}"
        valid_letters = false
        break
      end
      if valid_letters
        url ="https://wagon-dictionary.herokuapp.com/#{@word}"
        json_string = open(url).read
        json_hash = JSON.parse(json_string)
        unless json_hash["found"]
          @result = "#{@word} is not in the English dictionary"
        end
      end
    end
  end

end
