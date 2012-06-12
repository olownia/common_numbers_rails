require 'common_numbers'
require 'active_model'

class NipValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    raw_value = record.send(before_type_cast) if record.respond_to?(before_type_cast.to_sym)
    raw_value ||= value

    record.errors.add(attr_name, :not_a_nip, filtered_options(raw_value)) unless CommonNumbers::Polish::Nip.new(value).valid?
  end

end

module ActiveModel

  module Validations

    module HelperMethods

      def validates_nip_of(*attr_names)
        validates_with NipValidator, _merge_attributes(attr_names)
      end

    end

  end

end
