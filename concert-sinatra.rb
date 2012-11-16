require 'sinatra'
require 'nokogiri'
require 'open-uri'

#download results if not there
before do
  headers "Content-Type" => "text/html; charset=utf-8"
end

	unless File.exist?('concert-calendar') 
		#system('wget http://xpn.org/concerts-events/concert-calendar')
		open("concert-calendar", "wb") do |file|
			open("http://xpn.org/concerts-events/concert-calendar") do |uri|
				file.write(uri.read)
			end
		end
	end

	url = File.open('concert-calendar')
	data = Nokogiri::HTML(open(url))
	url.close


get "/" do
	@concerts = data.css("tbody").css("tr")
	@venue = params[:string]
	erb :concerts
erb:index
end

get "/concerts/:string" do

	
	#parse concert data
	@concerts = data.css("tbody").css("tr")
	@venue = params[:string]
	erb :concerts
end

