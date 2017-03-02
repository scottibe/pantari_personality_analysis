# RubyWrapperWatson

This is RubyWrapperWatson. A simple Ruby wrapper for IBM's Watson computer system APIs. Specifically, this gives access to the Personality Insights API and the Tone Analyzer API. 

RubyWrapperWatson takes input in two forms. The first is plain text, either in a string or read from a file. The second is a Twitter username. If given a username it will analyze the text from the tweets of that user's timeline and return an object with the personality or tone analysis scores. 

## Usage

First, you will need to obtain Watson credentials from: 
"https://console.ng.bluemix.net/dashboard/apps/"

You must enter the credentials in the .env file in the root directory and match them up with the variables in the constructor methods in PersonalityApiCaller and ToneApiCaller.

Descriptions for what all the scores mean for the Personality Insights can be found in hash form in the description.rb file  

Currently you must CD into the Gem directory and type: 
```
rake console
```
to use this gem.

To get a personality analysis with plain text
```
analysis = PersonalityAnalysis.create_analysis('input_text')
```
This will return an instance of the PersonalityAnalysis class with a score for each of the 22 personality characteristics plus the word count.

The scores are percentiles based on the average scores of the general population. If a score is 90% for a particular characteristic, the author of that text exhibits that characteristic more than 90% of the population.

Where input_text is a string of text.
To analyize from a file with plain text
```
analysis = PersonalityAnalysis.create_analysis(File.open("path/to/file.txt", "r"))
```

The same can be done for Tone Analysis, which analyzes the tone of a particular piece of writing. Simply change PersonalityAnalysis to ToneAnalysis.

To analyze the tweets from a specific twitter user:
```
analysis = PersonalityAnalysis.create_twitter_analysis('twitter_user_name')
```
You do not need to include the @ symbol in front of the user_name.

The same can be done to analyze the tone of the tweets, again, just replace PersoanlityAnalysis with ToneAnalysis. 

To get the raw data back in JSON format from the watson service:
```
data = PersonalityApiCaller.new(text_or_file_input)
```
```
json_data = data.get_data
```

to parse this:
```
parsed = JSON.parse(json_data)
```  

Again, the same can be done for the Tone Analysis, simply replace PersonalityApiCaller with ToneApiCaller and get_data with get_response.

You will notice there are more data points in the raw data. 
to find out more about these scores, you can visit:
"https://console.ng.bluemix.net/dashboard/apps/"

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby_wrapper_watson'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby_wrapper_watson


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ruby_watson_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

