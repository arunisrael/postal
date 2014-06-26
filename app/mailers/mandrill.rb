class Mandrill
  include BaseMailer

  def initialize(msg)
    @msg = msg
    @post_options = { 'Content-Type' => 'application/json' }
  end

  def format_message
    form = {}
    form[:key] = ENV['MANDRILL_API_KEY']
    form[:message] = {
      text: @msg.body,
      subject: @msg.subject,
      from_email: @msg.from,
      from_name: @msg.from_name,
      to: [
        {
          email: @msg.to,
          name: @msg.to_name,
          type: 'to'
        }
      ]
    }
    form.to_json
  end

  def prepare_data
    @request.body = format_message
  end
end
