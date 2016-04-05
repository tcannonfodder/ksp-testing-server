require 'rubygems'; require 'bundler'; Bundler.require

require 'byebug'
require 'faraday'
require 'json'

dir = File.expand_path('..', __FILE__)
require dir + '/config'

def get_or_post(path, opts={}, &block)
  get(path, opts, &block)
  post(path, opts, &block)
end

get '*' do
  mock_response
end

post '*' do
  mock_response
end

def mock_response
  begin
    #byebug
    content_type :json
    # puts "GOT REQUEST"
    # puts params.inspect
    # load_response("time.json")
    # status 200 and return
    if time?
      load_response("time.json")
    elsif response_1?
      load_response("response-target-body-1.json")
    elsif response_2?
      load_response("response-target-body-2.json")
    elsif response_3?
      load_response("response-target-body-3.json")
    else
      status 404 and return
    end
  rescue Exception => e
    puts e.message
  end
end

def load_response(filename, load=true)
  dir = File.expand_path('..', __FILE__)
  puts "SENDING #{filename}"
  if load
    x = File.read(File.join(dir, filename))
    # puts x
    x
  end
end

def time?
  params.include? "v.missionTime"
end

def response_1?
  params.include? "o.maneuverNodes"
end

def response_2?
	params.include? "currentReferenceBodyRadius"
end

def response_3?
	params.include? "vesselCurrentPositionRelativePosition"
end