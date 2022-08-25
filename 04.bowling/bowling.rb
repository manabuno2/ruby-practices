# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X' # strike
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end
frames = shots.each_slice(2).to_a
point = 0
frames.each_with_index do |frame, i|
  point += frame.sum
  next if i >= 9

  if frame[0] == 10 # strike

    point += if frames[i + 1][0] == 10 # 次のフレームもストライクだった場合の加算点を計算
               frames[i + 1][0].to_i + frames[i + 2][0].to_i
             else # 次のフレームがストライクではなかった場合の加算点を計算
               frames[i + 1][0].to_i + frames[i + 1][1].to_i
             end
  elsif frame.sum == 10 # spare

    point += frames[i + 1][0].to_i
  end
end

puts point
