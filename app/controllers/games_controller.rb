class GamesController < ApplicationController
  def new
    @grid = []

    10.times do
      @grid << [*'A'...'Z'].sample
    end
  end

  def score
    grid = params[:token].chars
    attempt = params[:attempt]
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    attempt_serialized = URI.open(url).read
    user_attempt = JSON.parse(attempt_serialized)

    attempt = attempt.upcase.chars
    letters_used = 0
    testing = attempt.all? { |z| grid.include?(z) }

    attempt.each do |letter|
      if grid.include?(letter)
        letters_used += 1
        index = grid.find_index(letter)
        grid.delete_at(index)
        # @message = "You used #{letters_used} letters from the grid! 🎉"
      else
        @message = "You used no letters from the grid! 😔"
      end
    end

    if testing == false
      @message = "You used no letters from the grid! 😔"
    elsif user_attempt["found"] == false
      @message = "You used #{letters_used} letters - but didn't make an English word! 😔"
    elsif user_attempt["found"] == true
      @message = "Awesome! You used #{letters_used} letters from the grid! 🎉"
    end


  end
end
