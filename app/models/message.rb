class Message
  include ActiveModel::Validations

  ATTRS = %w(to to_name from from_name subject body)

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  INVALID_EMAIL_MESSAGE = 'must contain a valid email address'

  EMPTY_FIELD_MESSAGE = "can't be blank"

  # synthesize getters/setters for each attribute
  attr_accessor *ATTRS

  # validate that each attribute has some content
  validates_presence_of *ATTRS

  # validates to/from has email address
  validates :to, format: { with: EMAIL_REGEX , message: INVALID_EMAIL_MESSAGE }
  validates :from, format: { with: EMAIL_REGEX, message: INVALID_EMAIL_MESSAGE }

  def initialize(params = {})
    ATTRS.each do |attr|
      send("#{attr}=", params[attr] || '')
    end
    convert_to_plain_text
  end

  def formatted_errors
    errs = []
    errors.messages.each do |k, v|
      v.each do |msg|
        errs << "#{k} #{msg}"
      end
    end
    errs
  end

  private

  # delegate text conversion to helper utility
  def convert_to_plain_text
    body ? self.body = HtmlToPlainText.convert_to_text(body) : ''
  end
end
