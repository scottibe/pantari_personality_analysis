require 'bundler'
Bundler.require(:default, :development, :production)
ENV['SINATRA_ENV'] ||= "development"

configure :development do
  ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
  )
end


configure :production do
  db =  URI.parse(ENV['DATABASE_URL'] || 'postgres_database_url')
  db = 'postgres://woxnoptdnjyxoh:55c367322688a6cfbf234a90b876fe1cb635e30d92ebb06481b41f2f4542983f@ec2-54-243-187-133.compute-1.amazonaws.com:5432/dbr09rncpm4j01'

  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'UTF8'

  )
end

require_relative '../app/controllers/pantari_application_controller.rb'
require_all 'app'
set :public_folder, File.dirname(__FILE__) + '/public'