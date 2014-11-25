class Board < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  belongs_to :users
  validates :title, presence: true, length: { minimum: 5 }
  validates :text, presence: true, length: { minimum: 5 }

  def user_name
  end

end
