require 'sinatra/base'
require 'haml'
require 'yaml'

class StakeSweeper < Sinatra::Base
  @@locals = {
      :bootstrap_theme   => '../brazil.css'
  }

  get '/' do
    haml :index, :locals => @@locals.merge(
        {
          :title => 'ODI World Cup Sweepstake',
          :teams => YAML.load(File.open('config/teams.yaml'))
        }
    )
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
