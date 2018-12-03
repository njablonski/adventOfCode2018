# list of frequency changes in data1.csv get applied
# in order to a starting frequency of 0

frequency <- 0
events <- read.csv("./data1.csv", header = TRUE, sep = ",")
for (event in events$delta) { frequency <- (frequency + event) }
print(frequency)
