
require 'jwt'
require_relative '../util/mysql_service.rb'

class Validate

  def initialize
    @chave = ENV['AUTH_SERVICE_METRICS_KEY']
  end

  def confirm(token)
    begin
      decode_token = JWT.decode token, @chave, true, { :algorithm => 'HS256' }
      valid = confirm_token_internal decode_token[0]['data']['token']
      { :validate => valid }
    rescue Exception
      { :error => '-503', :message => 'Token inválido' }
    end
  end

  private
    def confirm_token_internal(token_internal)
      mysql = MysqlService.new
      result = mysql.select "SELECT * FROM metrics.auth WHERE token = '#{token_internal}'"
      !result.empty?
    end
end