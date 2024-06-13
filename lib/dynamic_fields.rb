class DynamicFields
  attr_reader :struct, :field_names, :data, :errors

  def initialize(struct, data)
    @struct = struct.symbolize_keys
    @field_names = struct.keys
    @data = data.symbolize_keys
    @errors = {}
  end

  def valid?
    error(:base, 'Object should be a hash') and return(false) unless data.is_a?(Hash)

    valid = true

    data.each do |field, value|
      valid &&= valid_field?(field, value)
      return false if @errors.present?
      error(field.to_sym, "Should have correct type: '#{struct[field.to_sym]}'") and return(false) unless valid
    end

    valid
  end

  private

  def valid_field?(field, value)
    error(field.to_sym, "Invalid field: '#{field}'") and return(false) unless field_names.include?(field.to_s)

    valid_type?(field, value)
  end

  def valid_type?(field, value)
    case type(field)
      in 'string' then value.is_a?(String)
      in 'integer' then value.is_a?(Integer)
      in { single_field: values } then
        value.is_a?(String) && values.any?(value.to_s)
      in { multiple_fields: values } then
        value.is_a?(Array) && (value - values).empty?
    else
      false
    end
  end

  def type(field)
    res = struct[field.to_sym]
    res.is_a?(Hash) ? res.with_indifferent_access : res
  end

  def error(field, msg)
    errors[field] = [] if errors[field].nil?
    errors[field] << msg
  end
end
