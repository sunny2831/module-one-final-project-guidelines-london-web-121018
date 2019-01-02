class QueenCLI

attr_reader :result

def welcome
  puts "Welcome to the Haus of RuPaul"
  gets_name
end

def gets_name
 puts "please choose your Haus name"
 result = gets.chomp
 player = User.find_or_create_by(name: result)
 puts "you are the leader of the Haus of #{result}"
end


end

# welcome
# gets_name
