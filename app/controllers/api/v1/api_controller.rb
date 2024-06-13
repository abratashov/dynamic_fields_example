# frozen_string_literal: true

module Api
  module V1
    class ApiController < ActionController::API
      # To simplify task we skip user authentication
      # before_action :authenticate_user

      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
      rescue_from StandardError, with: :api_error

      private

      def record_not_found(error)
        render json: { error: { message: error.message, key: "#{error.model.downcase}_not_found" } }, status: :not_found
      end

      def api_error(error)
        render json: { error: { message: error.message, key: error } }, status: :unprocessable_entity
      end

      def record_invalid(error)
        render status: :unprocessable_entity,
               json: { error: { message: error.message, key: "#{error.record.class.name.downcase}_invalid",
                                context: error.record.errors.as_json } }
      end

      def service_error!(service)
        return if service.success

        status = service.status || :unprocessable_entity
        render json: { error: { message: service.error, key: 'api_error' } }, status:
      end
    end
  end
end
