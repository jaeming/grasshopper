class Message < ActiveRecord::Base
  belongs_to :board

  def board_name
    puts "board name here"
  end

  def user_name
    puts "user name here"
  end
end
