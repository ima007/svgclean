require 'nokogiri'

fileNames = Dir["*.svg"]
iterator = 0

puts 'Starting cleanup....'

for index in 0 ... fileNames.size
  doc = Nokogiri.XML(IO.read(fileNames[index]))
  svg = doc.at('svg')
  nodes = svg.children
  nodes = nodes.xpath("//*[@style='display:none;']")
  if nodes.size > 0
    puts ' ========'
    puts fileNames[index]
    iterator = iterator + 1
    puts '---> ' + nodes.size.to_s + ' display:none; nodes found'
    puts ' ========'
  end
  nodes.remove
  open(fileNames[index], 'w+') do |fileModify|
    fileModify << doc.to_xml
  end
end
puts iterator.to_s + ' files modified.'
