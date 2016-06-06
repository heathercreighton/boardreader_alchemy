class TickerController < ApplicationController
  def index
  end

  def result

	  count = 0
		response = []
		resultsArray = []
		@results = Result.all
		@results.delete_all





		# store query in Query table

		@queries = Query.new
		@queries.query = params[:ticker]
		@queries.save



			# Hits the Boardreader API and returns a JSON response

			@ticker = params[:ticker]
			puts "ticker: #{@ticker}"
			apikeyBr = "#{ENV['br_apikey']}"
			

			brquery = "http://api.boardreader.com/v1/Boards/Search?key=" + "#{apikeyBr}" + "&query=" + "#{@ticker}" + "&limit=5&match_mode=extended&filter_language=en&rt=json"

			puts brquery
			response = HTTParty.get(brquery)

			
			# Parses the JSON into an array
			resultsArray = JSON.parse(response)

			entries = resultsArray['response']['Matches']['Match']
			puts entries


			# Determine the length of the array
			length = entries.length


					# For each url in our array, send to the alchemyAPI and return the results to 'response'
			 length.times do 
				

					# Encodes the uri for the alchemyAPI
					encodeUrl = URI.encode("#{entries[count]['Url']}", /(?!\.)\W/)
					
 					#Strips off the beginning double quotation marks 
					oldUrl = "#{encodeUrl}".gsub("%5B%22","")
					


					# Strips of the ending double quotation marks
					myUrl = oldUrl.gsub("%22%5D","")
					myTarget = "#{@ticker}"
					

					apikey = "#{ENV['alchemy_apikey']}"
					

				 	alcquery = "http://gateway-a.watsonplatform.net/calls/url/URLGetTargetedSentiment?target=#{myTarget}&url=" + "#{myUrl}" + "&apikey=" + "#{apikey}" + "&outputMode=json&showSourceText=1&sourceText=cleaned"
					
					
# Hits the AlchemyAPI
					response = RestClient.get(alcquery)


	# 'response' is parsed in to 'alcresult' and collected into an table called "Result".
					alcresult = JSON.parse(response)

					if alcresult["status"] != "ERROR"

# Adds the results from alchemy to our database
						report = Report.new
						report.url = entries[count]['Url']
						report.pub_date = entries[count]['Published']	
						report.clean_text = alcresult["text"]
						report.score = alcresult["docSentiment"]["score"]
						report.save
	

#Send the data from alchemy to the result table to our view
						result = Result.new
						result.ticker = @ticker
						result.company = "company"
						result.urltext = alcresult["text"]
						result.url = alcresult["url"]
						result.senttype = alcresult["docSentiment"]["type"]
						result.score = alcresult["docSentiment"]["score"]
						result.save
						puts alcresult["url"], alcresult["docSentiment"]["type"], alcresult["docSentiment"]["score"]

						
					end
				
					count += 1
				end

	 @results = Result.all



 	end
end
