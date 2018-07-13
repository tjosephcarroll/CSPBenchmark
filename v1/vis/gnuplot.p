# Output to a svg file
set terminal svg size 1280,1024

# Set the aspect ratio of the graph
set size 1, 1

# The file to write to
set output "timeseries.svg"

# The graph title
set title "Benchmark Testing"

# Where to place the legend/key
set key left top

# Draw grid lines oriented on the y axis
set grid y

# Specify that the x-series data is time data
set xdata time

# Specify the *input* format of the time data
set timefmt "%s"

# Specify the *output* format for the x-axis tick labels
set format x "%S"

# Label the x-axis
set xlabel 'Test Time (s)'

# Label the y-axis
set ylabel 'Response Time (ms)'

# Tell gnuplot to use tabs as the delimiter instead of spaces (default)
set datafile separator '\t'

# Plot the data
plot "test.tsv" every ::2 using 2:5 title ' ' with points