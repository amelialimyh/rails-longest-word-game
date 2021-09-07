class GamesController < ApplicationController
  def new
    @letters = []
    10.times{@letters << ('A'..'Z').to_a.sample}
    # need to use {} instead of () because it is the syntax
    return @letters
  end

  def score
    
  end
end
