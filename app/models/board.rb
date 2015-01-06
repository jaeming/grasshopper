class Board < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  belongs_to :user
  validates :title, presence: true, length: { minimum: 5 }
  validates :text, presence: true, length: { minimum: 5 }
  validates :user, presence: true

  require 'elasticsearch/model'
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
end

Board.import