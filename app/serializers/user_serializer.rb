class UserSerializer < ActiveModel::Serializer
  attributes :id, :user_info
  has_one :tenant

  def user_info
    object.user_info ? DynamicRecordSerializer.new(object.user_info) : {}
  end
end
