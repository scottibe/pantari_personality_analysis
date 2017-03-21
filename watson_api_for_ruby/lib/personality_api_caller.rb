require_relative "ruby_wrapper_watson/version"
require 'json'
require 'excon'
require "dotenv"
require 'pry'
  Dotenv.load

class PersonalityApiCaller   

  attr_accessor :url, :username, :password, :input

  def initialize(input)
    @url = "https://gateway.watsonplatform.net/personality-insights/api"
    @username = "2547e262-d9ee-4ca2-8ef6-a4982a57a050"
    @password = "SCaQGN5855Zq"
    @input = input
  end   

  def get_data
    response = Excon.post(@url + "/v3/profile",
    :body     => @input,
    :headers  => {
      "Content-Type"            => "text/plain",
      "Content-Language"        => "en",
      "Accept-Language"         => "en"
    },
    :query    => {
      "raw_scores"              => true,
      "consumption_preferences" => true, 
      "version"                 => "10-20-2016" 
    },
    :user                       => @username,
    :password                   => @password)

    response.body
  end

   def scores_to_hash
    array = []
    score_array = []
    data_object = JSON.parse(get_data, :object_class => OpenStruct)
    count = {:word_count => data_object.word_count}
    array += [data_object.personality, data_object.needs, data_object.values]
    begin
    array.each do |result|
      result.each do |score|
        score_array += [score.name.gsub(" ", "_").gsub("-", "_").downcase.to_sym, score.percentile]
      end 
    end 
    rescue
    end  
    hash = Hash[*score_array]
    hash = hash.each_pair do |k, v|
      hash[k] = (v * 100).to_i
    end  
    hash = count.merge!(hash)
  end

end
