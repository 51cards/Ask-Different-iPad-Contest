require 'open-uri'
require 'json'
#require 'iconv'
require 'net/http'
require 'zlib'
require 'ap'

user_ids = {
  13414 => 'gentmatt', 9388 => 'Daniel L', 9495 => 'stuffe',
  8318 => 'jtbandes', 4408 => 'Mathias Bynens',
  3117 => 'Adam Eberbach', 219 => 'Adam Davis',
  292 => 'Ian C.', 13 => 'Kyle Cronin', 5472 => '*bmike',
  218 => '*Senseful', 638 => '*Moshe', 13247 => '*Graeme Hutchison',
  11791 => '*jaberg', 181 => '*jmlumpkin', 7001 => '*AJ.',
  11118 => '*penguinrob', 18387 => '*Andrew Larsson',
  11610 => '*Michiel', 1922 => '*KatieK', 12285 => '*Timothy M-H',
  116 => '*Chris W Rea', 3791 => '*Hippo', 20459 => '*R.M.'
}

user_names = {}

user_ids.keys.each do |key|
  user_names[user_ids[key]] = key
end


data = ""
user = 13


user = user_names[ARGV[0]] unless ARGV.length == 0

user_posts = []

['questions', 'answers'].each do |kind|
  page = 0
  begin
    page += 1
    posts = "http://api.stackexchange.com/2.0/users/#{user}/#{kind}?fromdate=1331856000&order=desc&sort=activity&site=apple&pagesize=100&page=#{page}&filter=!-q2RldsE&key=oRRUIfSKB0gCiJ0jiYpPJQ(("
    data = JSON.parse(Zlib::GzipReader.new(open(posts)).read)
    items = data['items']
    items.each do |item|
      user_posts << item
    end
  end while data['has_more']
end

user_posts.sort! do |a, b|
  b['score'] <=> a['score']
end

count = 1
user_posts.each do |post|
  puts "%2i: %s" % [post['score'], post['title']]
  puts '='*80 if count == 35
  count += 1
end
  


puts "requests left: #{data['quota_remaining']} of #{data['quota_max']}"