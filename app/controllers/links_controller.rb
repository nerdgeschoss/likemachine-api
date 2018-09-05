class LinksController < ApplicationController
  include ActionController::Live
  include ActionController::MimeResponds
  before_action :require_login, only: [:destroy, :create]

  def index
    respond_to do |format|
      format.json do
        render json: Link.all
      end
      format.event_stream do
        response.headers['Content-Type'] = 'text/event-stream'
        sse = SSE.new(response.stream)
        begin
          Link.on_change do |link|
            if link
              resource = ActiveModelSerializers::SerializableResource.new(link, adapter: :json, scope: current_user).as_json
              sse.write(resource, event: 'change')
            else
              sse.write(nil, event: 'ping')
            end
          end
        rescue ClientDisconnected
        ensure
          sse.close
        end
        render nothing: true
      end
    end
  end

  def show
    render json: link
  end

  def create
    render json: Link.create!(url: params.require(:url), author: current_user)
  end

  def destroy
    authorize!(link).destroy
  end

  private

  def link
    @link ||= Link.find(params[:id])
  end
end
