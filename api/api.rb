require 'sinatra'
require 'json'
require_relative '../src/service/validate.rb'

set :bind, '0.0.0.0'

post '/'do
  content_type 'json'
  response.headers["Access-Control-Allow-Origin"] = "*"

  validade = Validate.new

  params = JSON.parse(request.body.read.to_s)

  result = validade.confirm params['auth']

  { :id => 'Validate', :jsonrpc => "2.0", :result => result }.to_json

end