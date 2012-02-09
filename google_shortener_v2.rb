require "google_url_shortener"
Google::UrlShortener::Base.api_key = "AIzaSyBBUz-GGksM66xJ0yiBAobxYyXH6cZ9CQs"

# read from input file
list_of_all_data = []
file = File.open("1.txt", "r")

file.each_line do |line|
  begin
    row_of_data = line.split("\"|\"")
    url = row_of_data.last.strip.gsub("\"", "")
    unless url == ""
      shortened_url = Google::UrlShortener.shorten!(url)
      list_of_all_data << (row_of_data << shortened_url)
    end
  rescue => err
    puts "Skipping \"#{url}\" because #{err}"
  end
end

# write links to output file
File.open("google_sample_output1.txt", "w") do |file|
  list_of_all_data.each do |row_of_data|
    file.puts(row_of_data)
  end
end


