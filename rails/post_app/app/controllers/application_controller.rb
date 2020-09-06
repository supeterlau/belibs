class ApplicationController < ActionController::Base
  def hello
    render html: "hello, rails"
  end
end
