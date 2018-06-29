#simple driver using ab
#Makes calls like 
#ab -n 1000000 -c 10 -g test.tsv http://localhost/
#So...
# #ruby drvier.rb 0 1 2 3
  # 0 -n number of requests
  # 1 -c number of connections
  # 2 -g filename
  # 3 full url
# #
# Output file https://blog.tom-fitzhenry.me.uk/2014/08/apache-bench-timings-visualised.html


n   = ARGV[0]
c   = ARGV[1]
g   = ARGV[2]
url = ARGV[3]

results = `ab -n {n} -c {c} -g {g} {url}`



