require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times{ @letters << ('A'..'Z').to_a.sample }
    # need to use {} instead of () because it is the syntax
    return @letters
  end

  def score
    @input = params[:input] # string
    @input_array = params[:input].split(//) # check if it matches with @input, output=array empty?
    @letters = params[:data_letters].split(" ") # array

    @letters.each do |letter|
      if @input_array.include?(letter)
        @input_array.delete_at(@input_array.index(letter))
      end
    end

    raw_json = URI.open("https://wagon-dictionary.herokuapp.com/#{@input}").read
    @readable = JSON.parse(raw_json)
    @found = @readable[:found] # real word check, output: true false?
    @box = nil
    if @found && @input.empty?
      @box = "Congratulations! #{@input} is a valid English word!"

    elsif @found == false
      @box = "Sorry but #{@input} is not a valid word."

    else
      @box = "Sorry but #{@input} can't be built out of #{@letters.join(", ")}."
    end
  end
end
