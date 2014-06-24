module BaseMailer
  attr_reader :sent

  def send_mail
    @sent = false
    init_uri_http
    init_post_request
    set_basic_auth
    prepare_data
    make_request
    process_response
  end

  def init_uri_http
    klass = self.class.name.upcase
    @uri = URI.parse(ENV["#{klass}_API_SEND_URI"])
    @http = Net::HTTP.new(@uri.host, @uri.port)
    @http.use_ssl = true
  end

  def init_post_request
    @request = Net::HTTP::Post.new(@uri.request_uri, @post_options || {})
  end

  def set_basic_auth
  end

  def prepare_data
  end

  def make_request
    @response = @http.request(@request)
  end

  def process_response
    @sent = @response.code.to_i == 200 ? true : false
  end
end
