class Api::V1::UsersController < Api::V1::ApiController
  before_action :set_resource

  def update
    service = Api::Users::Update.call(user: @user, params: params[:user])

    service_error!(service) and return if service.failure?

    render json: service.user
  end

  private

  def set_resource
    # To simplify task we skip user authorization
    # @user = current_user.users.find(params[:id])

    @user = User.find(params[:id])
  end
end
