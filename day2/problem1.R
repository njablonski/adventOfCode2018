# list of box IDs in data1.csv
# count number of IDs that have a character that appears exactly twice (doubles)
# count number of IDs that have a character that appears exactly three times (triples)
# multiply doubles count by triples count to produce a checksum
# note that an ID can count towards the doubles count and the triples count on different characters

# install.packages("hashmap", repos = "http://cran.us.r-project.org")
library(hashmap)

boxes <- read.csv("./data1.csv", header = TRUE, sep = ",")
doubles <- 0
triples <- 0

for (box in boxes$id) {
  characters <- strsplit(box, "")[[1]]
  counter <- hashmap(letters, rep(0, times = 26))
  is_double <- FALSE
  is_triple <- FALSE
  for (character in characters) {
    counter$insert(character, (1 + counter$find(character)))
  }
  for (letter in letters) {
    if (counter$find(letter) == 2 & !is_double) {
      doubles <- (doubles + 1)
      is_double <- TRUE
    }
    if (counter$find(letter) == 3 & !is_triple) {
      triples <- (triples + 1)
      is_triple <- TRUE
    }
  }
}

print(doubles)
print(triples)
print(doubles * triples)
