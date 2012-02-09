require "google_url_shortener"
Google::UrlShortener::Base.api_key = "AIzaSyBBUz-GGksM66xJ0yiBAobxYyXH6cZ9CQs"

# read from input file
list_of_all_data = []
File.open("test_file.txt", "r") do |file|
  file.each_line do |line|
    begin
      row_of_data = line.split("|")
      url = row_of_data.last.strip[1..-1]
      shortened_url = Google::UrlShortener.shorten!(url)
      list_of_all_data << (row_of_data << shortened_url)
    rescue => err
      puts "Skipping \"#{line}\" because #{err}"
    end
  end
end

# write links to output file
File.open("google_sample_output1.txt", "w") do |file|
  list_of_all_data.each do |row_of_data|
    file.puts(row_of_data)
  end
end


