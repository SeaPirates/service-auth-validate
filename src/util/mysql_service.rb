
require 'mysql2'
require 'yaml'

class MysqlService
  def initialize
    config = File.read('config-db.yml')
    dbConfig = YAML.load config

    conexao(
        dbConfig["database"]["dev"]['host'],
        dbConfig["database"]["dev"]['porta'],
        dbConfig["database"]["dev"]['usuario'],
        dbConfig["database"]["dev"]['senha']
    )
  end

  def select(query)
    dados = Array.new
    result = @client.query(query, :array => true)

    result.each do |r|
      dados.push r
    end
    return dados
  end

  def instrucoes_params(query)

    if /SELECT/.match(query)
      raise 'Essa função não suporta SELECT'
    end

    @client.query(query)
  end

  private
  def conexao(host, port, usuario, senha)
    @client = Mysql2::Client.new(
        :host => host,
        :port => port,
        :username => usuario,
        :password => senha
    )
  end
end