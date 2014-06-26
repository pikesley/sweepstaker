require 'sinatra/base'
require 'haml'
require 'yaml'

class Team
  attr_reader :name, :backer, :status

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

    if @backer == 'Nobody'
      s << ' btn-info'
    end

    s << '"'
    s << '>'
    s << @name.to_s
    s << '<br />'
    s << '<em'
    s << ' class="nobody"' if @backer == 'Nobody'
    s << '>'
    s << @backer
    s << '</em>'
    s << '</button>'

    s
  end
end

class Teams < Array
  attr_reader :nobodies

  def initialize conf_file
    @nobodies = 0

    y = YAML.load File.open conf_file
    y.each_pair do |team, attributes|
      t = Team.new team, attributes['backer'], attributes['status']
      self << t
      @nobodies += 1 if t.backer == 'Nobody'
    end

    self.sort_by! { |x| [ x.status, x.name ] }
  end
end

class StakeSweeper < Sinatra::Base

  @@config = YAML.load(File.open('config/config.yaml'))

  get '/' do
    haml :index, :locals => {
          :title => @@config['title'],
          :teams => Teams.new(@@config['data_source']),
          :bootstrap_theme   => '../brazil.css',
          :additional_css   => '../odi.css'
        }
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
