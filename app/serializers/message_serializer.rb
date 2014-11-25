class MessageSerializer < ActiveModel::Serializer
  attributes :board_name, :id, :body, :user_name, :created_at

  def board_name
    object.board_name
  end

  def user_name
    object.user_name
  end

  def created_at
    object.created_at.strftime('%B %d, %Y')
  end
end
