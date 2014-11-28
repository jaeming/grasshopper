class BoardSerializer < ActiveModel::Serializer
  attributes :id, :title, :text, :user_name, :created_at

  def user_name
    object.user.name || object.user.email
  end

  def created_at
    object.created_at.strftime('%B %d, %Y')
  end
end
