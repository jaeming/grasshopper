class Board < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }
  validates :text, presence: true, length: { minimum: 5 }
end
