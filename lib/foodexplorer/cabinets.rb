class Cabinets < CLI
	attr_accessor :name, :contents

	@@all = []

	def initialize
		self.name = "Cabinet #{@@all.length + 1}"
		contents = []
		random_count = rand(0..3)
		if random_count == 0
			puts "Uh oh! Looks like this cabinet is empty."
			@@all << self
			kitchen_intro
		else
			loop do
				contents << Product.new(self.name)
				break if contents.length == random_count
			end
		end
		@@all << self
		display_cabinet(contents)
	end

	def display_cabinet(contents)
		case contents.length
		when 3
			puts "Let's see what's in #{self.name}..."
			sleep 2
			puts "Looks like we have...\n#{"(1)".on_blue} #{contents[0].name},\n#{"(2)".on_blue} #{contents[1].name}, and\n#{"(3)".on_blue} #{contents[2].name}."
		when 2
			puts "Let's see what's in #{self.name}..."
			sleep 2
			puts "Looks like we have...\n#{"(1)".on_blue} #{contents[0].name}, and\n#{"(2)".on_blue} #{contents[1].name}."
		else
			puts "Let's see what's in #{self.name}..."
			sleep 2
			puts "Hmm... not very full, is it? Looks like we just one item:\n#{"(1)".on_blue} #{contents[0].name}."
		end
		sleep 1
		product_info_from_cabinet(contents)
	end

	def product_info_from_cabinet(contents)
		puts "To find out more information about an item, type the item number below. To go back, type #{"Back".on_red}."
		print ">> "
		input = gets.to_s.strip.downcase
		if input.include? "exit"
			nav.goodbye
		elsif input.include? "back"
			puts "Let's head back to the kitchen."
			sleep 2
			kitchen_intro
		elsif input == "1"
			contents[0].show_basic_info
		elsif input == "2"
			contents[1].show_basic_info
		elsif input == "3"
			contents[2].show_basic_info
		else
			puts "Oops.. I'm not sure I understood what you'd like to do. Let's try that again."
			sleep 2
			product_info_from_cabinet(contents)
		end
	end

	def self.all
		@@all
	end

end