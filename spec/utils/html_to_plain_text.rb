require 'minitest/autorun'
require 'minitest/spec'
require_relative '../../app/utils/html_to_plain_text'

describe HtmlToPlainText do
  it 'converts html content to plain text' do
    input = '<h1>Your Bill</h1><p>$10</p>'
    output = "*********\nYour Bill\n*********\n\n$10"
    HtmlToPlainText.convert_to_text(input).must_equal(output)
  end

  it 'leaves plain text content alone' do
    input = 'h1 h2 p span'
    output = input
    HtmlToPlainText.convert_to_text(input).must_equal(output)
  end

end
