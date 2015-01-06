class Message < ActiveRecord::Base
  belongs_to :board
  belongs_to :user
  validates :body, presence: true, length: { minimum: 5 }
  validates :user, presence: true

  require 'elasticsearch/model'
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
end
