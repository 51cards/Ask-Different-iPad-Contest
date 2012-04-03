require 'open-uri'
require 'json'
#require 'iconv'
require 'net/http'
require 'zlib'
require 'ap'

$out = ""

def write(str)
  $out += "#{str}\n"
  puts str
end

def array_sum(arr)
  arr.reduce {|a,b| a+b}
end
  

user_ids = {
  13414 => 'gentmatt', 9388 => 'Daniel L', 9495 => 'stuffe',
  8318 => 'jtbandes', 4408 => 'Mathias Bynens',
  3117 => 'Adam Eberbach', 219 => 'Adam Davis',
  292 => 'Ian C.', 13 => 'Kyle Cronin', 5472 => '*bmike',
  218 => 'Senseful', 638 => '*Moshe', 13247 => '*Graeme Hutchison',
  11791 => '*jaberg', 181 => '*jmlumpkin', 7001 => '*AJ.',
  11118 => '*penguinrob', 18387 => '*Andrew Larsson',
  11610 => '*Michiel', 1922 => '*KatieK', 12285 => '*Timothy M-H',
  116 => '*Chris W Rea', 3791 => '*Hippo', 20459 => '*R.M.',
  9058 => '*patrix', 20749 => '*illep', 4160 => '*Steve Moser',
  20448 => '*jt703'
}

user_scores = []
data = ""

count = 1

user_ids.keys.each do |user|
  print "\rprocessing %2i of %2i" % [count, user_ids.length]
  
  post_scores = []
  
  ['questions', 'answers'].each do |kind|
    page = 0
    begin
      page += 1
      posts = "http://api.stackexchange.com/2.0/users/#{user}/#{kind}?fromdate=1331856000&order=desc&sort=activity&site=apple&pagesize=100&page=#{page}&key=oRRUIfSKB0gCiJ0jiYpPJQ(("
      data = JSON.parse(Zlib::GzipReader.new(open(posts)).read)
      items = data['items']
      items.each do |item|
        post_scores << item['score'] unless item['closed_date']
      end
    end while data['has_more']
  end
  
  total_score = array_sum(post_scores)
  
  posts = post_scores.sort.last(35)
  
  top35_score = array_sum(posts)
  median_score = array_sum(posts.first(20).last(5))/5.0
  
  user_scores << [user, top35_score, median_score, total_score]
  
  count += 1; sleep 0.2
end

print "\r"

user_scores.sort! do |a, b|
  b[1] <=> a[1]
end

user_scores.each do |user|
  write("%20s: #{user[1]} (%1.2f) (#{user[3]})" % [user_ids[user[0]], user[2]])
end

puts "requests left: #{data['quota_remaining']} of #{data['quota_max']}"

File.open("results/#{Time.new.to_s}", "w") << $out
