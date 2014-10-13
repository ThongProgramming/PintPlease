class TimelineController < ApplicationController
  require 'json'
  require 'open-uri'
  require 'net/https'

  def get_data
    source = "https://leetathome.asuscomm.com/PintPlease/api1/timeline/index"
    json = JSON.load(open(source,{ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}).read)
    @data = json['payload']['posts']
  end
end
