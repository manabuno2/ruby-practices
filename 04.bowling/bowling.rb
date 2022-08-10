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
frames = []
shots.each_slice(2) do |s|
  frames << s
end

point = 0
score_pattern_index = []
frames.each_with_index do |frame, i|
  if frame[0] == 10 # strike
    point += 10
    score_pattern_index[i] = 1
    next
  elsif frame.sum == 10 # spare
    point += 10
    score_pattern_index[i] = 2
  else
    point += frame.sum
    score_pattern_index[i] = 0
  end
end
score_pattern_index.each_with_index do |add_point, i|
  break if i == 9 # 10フレームよりあとは加算処理をしない

  case add_point
  when 1 # strikeの加算点を計算
    point += if frames[i + 1][0] == 10 # 次のフレームもストライクだった場合の加算点を計算
               frames[i + 1][0].to_i + frames[i + 2][0].to_i
             else # 次のフレームがストライクではなかった場合の加算点を計算
               frames[i + 1][0].to_i + frames[i + 1][1].to_i
             end
  when 2 # spareの加算点を計算
    point += frames[i + 1][0].to_i
  when 0 # strikeでもspareでないときは加算せずに次のループ処理へ遷移
    next
  end
end
puts point
