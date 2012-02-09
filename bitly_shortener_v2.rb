require "bitly"

Bitly.use_api_version_3
bitly = Bitly.new("verdi327", "R_0d95b1830c5613637ac3f43ff70234e8")

# read from input file
list_of_all_data = []
file = File.open("1.txt", "r")

file.each_line do |line|
  begin
    row_of_data = line.split("\"|\"")
    url = row_of_data.last.strip.gsub("\"", "")
    unless url == ""
      shortened_url = bitly.shorten(url)
      list_of_all_data << (row_of_data << shortened_url)
    end
  rescue => err
    puts "Skipping \"#{url}\" because #{err}"
  end
end

# write links to output file
File.open("bitly_sample_output.txt", "w") do |file|
  list_of_all_data.each do |row_of_data|
    file.puts(row_of_data)
  end
end
