pages_with_questions = {}

lines_grabbed = ""
key = ""

File.open("story.txt", "r") do |infile|

  while line = infile.gets
    if line.index("~p")
    	key = line
    	lines_grabbed = ""
    else
		lines_grabbed += line
  	end
	pages_with_questions[key] = lines_grabbed
  end
end

user_quits_game = false
until user_quits_game

	# display first page and choices
	p1 = pages_with_questions.select { |k, v| k.index("~p1") }

	num_choices = 0

	# display all lines of page, both text and choices
	p1.each do |k, v|
		if k.index(":c")	# if line is a choice, prefix line with a number
			num_choices += 1
			print "#{num_choices}. "
		end
    	puts v
	end

	# prompt user for input  (and validate input)
	puts "Enter choice number."
	choice_is_valid = false
	until choice_is_valid do
		choice = gets.chomp
		if choice.to_i >= 1 && choice.to_i <= num_choices
			choice_is_valid = true
		else
			puts "invalid choice, please re-enter."
		end
	end

	# search for next page based on user's choice
	pages_with_questions.select { |k, v| key = k if k.index(":c"+choice) }
	next_page = key.to_s.rpartition(':')[2]


	# display the page for the users choice
	pages_with_questions.select { |k, v| puts v if k.index(next_page) }

	# prompt user for input to continue game
	puts "Enter 'y' to play again, anything else to quit."
	user_quits_game = gets.chomp != 'y'

end
