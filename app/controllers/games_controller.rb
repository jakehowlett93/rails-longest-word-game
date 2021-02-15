require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ("A".."Z").to_a.sample(10)
  end

  def score
    @result = "correct"
    @letters = params[:letters].split(" ")
    @word = params[:word].upcase

    @word.each_char.with_index do |char, index|
      if @letters.include? char
        @letters.slice(index, 1)
      else
        @result = "Invalid letters"
      end
      url ="https://wagon-dictionary.herokuapp.com/#{@word}"
      json_string = open(url).read
      json_hash = JSON.parse(json_string)
      unless json_hash["found"]
        @result = "Word not in dictionary"
      end
    end
  end

end
