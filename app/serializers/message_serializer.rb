class MessageSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper
  attributes :board_name, :board_id, :id, :body, :user_name, :created_at

  def board_name
    object.board.title
  end

  def user_name
    object.user.name || object.user.email
  end

  def created_at
    time_ago_in_words(object.created_at) + " ago"
  end
end
