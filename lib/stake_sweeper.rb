require 'sinatra/base'
require 'haml'
require 'yaml'

class Team
  def initialize name, backer, status
    @name = name
    @backer = backer
    @status = status
  end

  def to_s
    s = ''
    s << '<button class="btn btn-block btn-'

    case @status
    when 'In'
      s << 'success'
    when 'Out'
      s << 'danger'
    end

    s << '"'
    s << '>'
    s << @name
    s << '<br />'
    s << '<em>'
    s << @backer
    s << '</em>'
    s << '</button>'

    s
  end
end

class Teams < Array
  def initialize conf_file
    y = YAML.load File.open conf_file
    y.each_pair do |team, attributes|
      t = Team.new team, attributes['backer'], attributes['status']
      self << t
    end
  end
end

class StakeSweeper < Sinatra::Base

  get '/' do
    haml :index, :locals => {
          :title => YAML.load(File.open('config/config.yaml'))['title'],
          :teams => Teams.new('config/teams.yaml'),
          :bootstrap_theme   => '../brazil.css',
          :additional_css   => '../odi.css'
        }
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
