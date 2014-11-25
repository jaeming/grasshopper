class Message < ActiveRecord::Base
  belongs_to :board

  def board_name
    board.title
  end

  def user_name
    puts "user name here"
  end
end
