file = File.read "diffstats_302.data"

dates = {}
mydate = nil
mydiff = nil
file.lines.each do |line|
  line = line.strip
  if line =~ /\d+-\d+-\d+/
    mydate = line
  elsif matcher = /(\d+) file/.match(line)
    mydiff = { :files => 0, :inserts => 0, :deletes => 0 }

    dates[mydate] = mydiff unless dates[mydate]
    dates[mydate][:files] += matcher[1].to_i
    matcher = /(\d+) insert/.match(line)
    dates[mydate][:inserts] += matcher[1].to_i if matcher
    matcher = /(\d+) delet/.match(line)
    dates[mydate][:deletes] += matcher[1].to_i if matcher
  else
    mydate = nil
    mydiff = nil
  end

end

puts "Date,Files,Inserts,Deletes"

dates.sort.each do |mydate,hash|
  puts "#{mydate},#{hash[:files]},#{hash[:inserts]},#{hash[:deletes]}"
end

