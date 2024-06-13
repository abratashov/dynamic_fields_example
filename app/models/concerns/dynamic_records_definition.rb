# frozen_string_literal: true

module DynamicRecordsDefinition
  extend ActiveSupport::Concern

  private

  # Defines fetching DynamicRecord by struct name
  def method_missing(missing_method, *args, &block)
    struct_names = tenant.dynamic_structs.pluck(:name)
    if struct_names.include?(missing_method.to_s)
      define_singleton_method(missing_method.to_sym) do |*_args|
        struct = dynamic_struct_owner.public_send(missing_method.to_sym)
        dynamic_records.find_by(dynamic_struct: struct)
      end

      public_send(missing_method, *args)
    else
      super
    end
  end
end
