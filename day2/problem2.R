# list of box IDs in data1.csv
# find the two IDs that differ by exactly one character
# return the common characters in both IDs

boxes <- read.csv("./data1.csv", header = TRUE, sep = ",")
found <- FALSE
common <- ""

for (prime_box in boxes$id) {
  if (!found) {
    prime_letters <- strsplit(prime_box, "")[[1]]
    for (compare_box in boxes$id) {
      differences <- 0
      compare_letters <- strsplit(compare_box, "")[[1]]
      for (index in (1:length(compare_letters))) {
        if(prime_letters[index] != compare_letters[index]) { differences <- (differences + 1)}
      }
      if (differences == 1) {
        print(prime_box)
        print(compare_box)
        found <- TRUE
      }
    }
  }
}
