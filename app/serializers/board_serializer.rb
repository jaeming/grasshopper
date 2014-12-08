class BoardSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :title, :text, :user_name, :created_at, :message_count, :url

  def user_name
    object.user.name || object.user.email
  end

  def created_at
    object.created_at.strftime('%B %d, %Y')
  end

  def message_count
    object.messages.count
  end

  def url
    board_path object
  end

end
