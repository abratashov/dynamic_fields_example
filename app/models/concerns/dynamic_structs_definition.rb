# frozen_string_literal: true

module DynamicStructsDefinition
  extend ActiveSupport::Concern

  private

  # Defines fetching DynamicStruct by name
  def method_missing(missing_method, *args, &block)
    struct_names = dynamic_structs.pluck(:name)
    if struct_names.include?(missing_method.to_s)
      define_singleton_method(missing_method.to_sym) do |*_args|
        dynamic_structs.find_by(name: missing_method)
      end

      public_send(missing_method, *args)
    else
      super
    end
  end
end
