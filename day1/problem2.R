# list of frequency changes in data1.csv get applied
# in order to a starting frequency of 0
#
# find first repeated frequency value

# install.packages("hashmap", repos = "http://cran.us.r-project.org")
library(hashmap)

frequency <- 0
counter <- 1
events <- read.csv("./data1.csv", header = TRUE, sep = ",")
found <- FALSE
repetition <- 0
history <- hashmap(frequency, counter)

while (found == FALSE) {
  for (event in events$delta) {
    frequency <- (frequency + event)
    counter <- (counter + 1)
    if(history$has_key(frequency) & !found) {
      repetition <- frequency
      found <- TRUE
    }
    history$insert(frequency, counter)
    print(counter)
  }
}

print(repetition)
