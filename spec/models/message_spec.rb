describe Message do
  before(:each) do
    @params = {
      'to' => 'fake@example.com',
      'to_name' => 'Ms. Fake',
      'from' => 'noreply@uber.com',
      'from_name' => 'Uber',
      'subject' => 'A Message from Uber',
      'body' => '<h1>Your Bill</h1><p>$10</p>'
    }
  end

  it 'can be created with no arguments' do
    Message.new.must_be_instance_of Message
  end

  it 'can be created with a hash' do
    Message.new(@params).must_be_instance_of Message
  end

  it 'is valid when all keys provided' do
    Message.new(@params).valid?.must_equal true
  end

  # message is invalid if any one field is missing
  Message::ATTRS.each do |attr|
    it "is invalid when #{attr} is missing" do
      @params.delete(attr)
      m = Message.new(@params)
      m.valid?.must_equal false
      m.formatted_errors.must_include "#{attr} #{Message::EMPTY_FIELD_MESSAGE}"
    end
  end

  it 'is invalid when 2 fields are missing' do
    @params.delete('body')
    @params.delete('subject')
    m = Message.new(@params)
    m.valid?.must_equal false
    m.formatted_errors.must_include "subject #{Message::EMPTY_FIELD_MESSAGE}"
    m.formatted_errors.must_include "body #{Message::EMPTY_FIELD_MESSAGE}"

  end

  it 'converts html body to plain text' do
    Message.new(@params).body.must_equal "*********\nYour Bill\n*********\n\n$10"
  end

  it 'is invalid when to email address is missing' do
    @params['to'] = 'to_email'
    m = Message.new(@params)
    m.valid?.must_equal false
    m.formatted_errors.must_include "to #{Message::INVALID_EMAIL_MESSAGE}"
  end

  it 'is invalid when from email address is missing' do
    @params['from'] = 'from_email'
    m = Message.new(@params)
    m.valid?.must_equal false
    m.formatted_errors.must_include "from #{Message::INVALID_EMAIL_MESSAGE}"
  end

  # TODO
  it 'is invalid when from contains multiple email addresses' do
    skip('pending')
  end

end
