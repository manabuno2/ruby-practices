require 'date'
require 'optparse'
options = ARGV.getopts("", "y:#{Date.today.year}", "m:#{Date.today.month}")
puts "      " +  options["m"] + "月 " + options["y"]
day_of_week = [ '日 ', '月 ', '火 ', '水 ', '木 ', '金 ', '土 ']
day_of_week.each do |x|
  print x
end

puts "\n"
begging_of_month = Date.new(options["y"].to_i, options["m"].to_i, 1) #月初日の暦日を生成する
start_cwday = begging_of_month.cwday #その月の1日の曜日
end_of_month = Date.new(options["y"].to_i, options["m"].to_i, -1) #月末日の暦日を生成する
(start_cwday).times do #その月の1日の曜日以前をブランクを挿入する
  if start_cwday == 7 # 日曜日(7)が返ってきたときは処理を行わない
    break
  end
  print "   "    
end
(begging_of_month..end_of_month).each do |x|
  if x.day <= 9
    print " "
  end
  print x.day
  print " "
  if x.saturday?
    puts "\n"
  end
end
