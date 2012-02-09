require "bitly"

Bitly.use_api_version_3
bitly = Bitly.new("verdi327", "R_0d95b1830c5613637ac3f43ff70234e8")

# read from input file
list_of_all_data = []
File.open("test_file.txt", "r") do |file|
  file.each_line do |line|
    begin
      row_of_data = line.split("|")
      url = row_of_data.last.strip[1..-1]
      shortened_url = bitly.shorten(url)
      list_of_all_data << (row_of_data << shortened_url.short_url)
    rescue
      puts "Skipping \"#{line}\" because no url was found"
    end
  end
end

# write links to output file
File.open("updated_whalden_file.txt", "w") do |file|
  list_of_all_data.each do |row_of_data|
    file.puts(row_of_data)
  end
end


