require_relative './initialize'
require 'sinatra'

post '/email' do
  req = JSON.parse(request.env['rack.input'].read)
  msg = Message.new(req)

  msg.valid? || report_error(msg.formatted_errors)

  mail = Postal::Settings::DEFAULT_MAILER.new(msg)

  mail.send_mail || report_error(['Can not send mail due to internal error'])

  { 'status' => '200' }.to_json
end

helpers do
  def report_error(errs)
    halt 400,    { 'errors' => errs }.to_json
  end
end
