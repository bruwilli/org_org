class ConfirmationNoCaseValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if ((confirmed = record.send("#{attribute}_confirmation")) &&
        confirmed.length > 0 &&
        value.length > 0 &&
        value.downcase != confirmed.downcase)
      record.errors.add(attribute, :confirmation, options)
    end
  end
end