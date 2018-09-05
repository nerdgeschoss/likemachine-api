class LinkSerializer < ApplicationSerializer
  attributes :id, :url, :title, :description, :image_url, :created_at, :updated_at, :liked, :like_count, :owned

  def liked
    object.likes.where(user: scope).any?
  end

  def like_count
    object.likes.size
  end

  def owned
    object.author_id == scope&.id
  end
end
