describe Postal::Settings do
  it 'should have a default mailer' do
    Postal::Settings::DEFAULT_MAILER.wont_be_nil
  end
end
