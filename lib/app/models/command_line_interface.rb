require 'rest-client'
require 'json'
require 'pry'
require 'rubygems'
require 'RMagick'
include Magick

class QueenCLI

attr_reader :player
attr_accessor :queen_name

def welcome
  puts "Welcome to the Haus of RuPaul"
  gets_name
  user_choice = queen_menu(gets_queen)
  shade_api(user_choice)
end

def gets_name
 puts "please choose your Haus name"
 result = gets.chomp
 @player = User.find_or_create_by(name: result)
 puts "you are the leader of the Haus of #{player.name}"
end

def gets_queen
 if @player.queens.empty?
   puts "Your haus does not have any queens. \n Please enter a queen name: "
   queen_name = gets.chomp
   response_string = JSON.parse(RestClient.get("http://www.nokeynoshade.party/api/queens?name=#{queen_name}"))
   params = {}
   params[:name] = response_string[0]["name"]
   params[:api_key] = response_string[0]["id"]
   queen = Queen.new(params)
  @player.queens << queen
 end
   puts "here are your legendary children: "
   array = []
   player.queens.each do |queen|
    array << queen.name
    puts  queen.name
   end
  array
end
 #response_hash = JSON.parse(response_string)


def queen_menu(array)
  result = {}
  puts "select one of your queens to get their bio"
  result[:queen] = gets.chomp
   while array.include?(result[:queen]) != true
     puts "Queen is not included in your list"
     result[:queen] = gets.chomp
     #binding.pry
   end
     str =  "what would you like to know about #{result[:queen]} select one of the following options \n
           1 - #{result[:queen]}'s place in her season \n
           2 - #{result[:queen]}'s picture \n
           3 - #{result[:queen]}'s quote \n
           4 - #{result[:queen]}'s tour dates in the UK"
      puts str
    result[:menu_choice] = gets.chomp.to_i
      while result[:menu_choice] >= 5
        puts str
      end
      result
   end

def shade_api(result)
api_array = JSON.parse(RestClient.get("http://www.nokeynoshade.party/api/queens?name=#{result[:queen]}"))
  case result[:menu_choice]
when 1
  #binding.pry
  api_array[0]["seasons"][0]["place"]
  puts "She came in place #{api_array[0]["seasons"][0]["place"]}"
when 2
  puts api_array[0]["image_url"]
  queen = ImageList.new(api_array[0]["image_url"])
  queen.display
when 3
  puts api_array[0]["quote"]
when 4
  puts "Coming Soon to London"
end

end

end

# alice.queens.empty?
#This is for the class






  #lists out the queen's from the user_queen table based on the user_id




# welcome
# gets_name
