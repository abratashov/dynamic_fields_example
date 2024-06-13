module Api
  module Users
    class Update
      include Interactor

      delegate :user, :params, to: :context

      before do
        # If need we can pass user ID
        # context.user = User.find_by(id: params[:user_id)
        context.fail!(error: 'user is missing') if user.blank?
        context.fail!(error: "user's params are missing") if params_blank?
      end

      def call
        ActiveRecord::Base.transaction do
          user_info = user.user_info || user_info_init

          context.fail!(error: user_info.errors.full_messages.join('. ')) unless user_info.update_data(user_info_data, merge: merge?)
        end
        context.user.reload
      end

      private

      def user_info_init
        user.dynamic_records.create(dynamic_struct: user.tenant.user_info, data: {})
      end

      def params_blank?
        # Allow data removing
        return false if user_info_data.is_a?(Hash)

        user_info_data.blank?
      end

      def params_hash
        params.dig(:user_info)
      end

      def user_info_data
        params_hash&.dig(:data) || {}
      end


      def merge?
        ActiveModel::Type::Boolean.new.cast(params_hash&.dig(:merge))
      end
    end
  end
end

