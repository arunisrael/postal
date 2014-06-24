class Mailgun
  include BaseMailer

  def initialize(msg)
    @msg = msg
  end

  def format_message
    form = {}
    form[:from] = "#{@msg.from_name} <#{@msg.from}>"
    form[:to] = "#{@msg.to_name} <#{@msg.to}>"
    form[:subject] = @msg.subject
    form[:text] = @msg.body
    form
  end

  def prepare_data
    @request.set_form_data(format_message)
  end

  def set_basic_auth
    @request.basic_auth(ENV['MAILGUN_API_USER'], ENV['MAILGUN_API_KEY'])
  end
end
