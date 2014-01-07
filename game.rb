pages_with_questions = {}

File.open("story.txt", "r") do |infile|
  while (line = infile.gets)
    if line.match /^~p\d$/
      pages_with_questions[line] = "this is page text"
    elsif line.match /^~p\d:c\d:p\d$/
      pages_with_questions[line] = "this is question text"
    end
  end
end

puts pages_with_questions