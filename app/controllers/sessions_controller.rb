class SessionsController < ApplicationController
  before_action :require_login, only: :destroy

  def create
    session = User.authenticate_facebook(params.require(:facebook_token)).sessions.create!
    render json: session
  end

  def destroy
    current_session.destroy
    head :no_content
  end
end
