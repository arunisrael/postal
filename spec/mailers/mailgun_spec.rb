# TODO: flesh out these tests in more detail
describe Mailgun do

  it 'can send mail successfully' do
    stub_request(:post, /.*/).to_return(body: 'passed', status: 200)
    Mailgun.new(Message.new).send_mail.must_equal true
  end

  it 'reports error code for unsuccessful sends' do
    stub_request(:post, /.*/).to_return(body: 'failed', status: 400)
    Mailgun.new(Message.new).send_mail.must_equal false
  end

end
