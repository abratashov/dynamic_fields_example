class Api::V1::UsersController < Api::V1::ApiController
  before_action :set_resource

  def update
    # TODO: update user
    render json: @user
  end

  private

  def set_resource
    # To simplify task we skip user authorization
    # @user = current_user.users.find(params[:id])

    @user = User.find(params[:id])
  end
end
