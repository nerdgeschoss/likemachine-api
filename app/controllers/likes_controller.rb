class LikesController < ApplicationController
  before_action :require_login, only: [:destroy, :create]

  def create
    current_user.likes.create! link_id: params.require(:link_id)
    head :no_content
  end

  def destroy
    like.destroy
    head :no_content
  end

  private

  def like
    @like ||= Like.find_by!(user: current_user, link_id: params.require(:link_id))
  end
end
