# each line of data1.txt describes a rectange drawn on x,y axes
# of a 1000x1000 grid, in the form:
#
# "#RECTANGLE_ID @ X_POSITION,Y_POSITION: X_DIMENSIONxY_DIMENSION"
#
# where the position coordinates define the top left corner of the
# rectange, with coordinate 0,0 being the top left corner of the grid
#
# find how many integer coordinate locations (x,y) are inside more than one rectangle

# rectangles gets the raw specification
rectangles <- read.csv("./data1.txt", header = TRUE, sep = " ")

# parse out position value
get_position <- function(raw_position_pair, which) {
  dropped_colon <- substr(raw_position_pair,1,nchar(as.character(raw_position_pair))-1)
  position <- sapply(strsplit(dropped_colon, ","), `[`, which)
  return(position)
}

# parse out dimension value
get_dimension <- function(raw_dimension_pair, which) {
  dimension <- sapply(strsplit(as.character(raw_dimension_pair), "x"), `[`, which)
  return(dimension)
}

# parse it out into a new dataframe with xpos, ypos, xdim, ydim
rectangles$xpos <- as.numeric(get_position(rectangles$positions, 1))
rectangles$ypos <- as.numeric(get_position(rectangles$positions, 2))
rectangles$xdim <- as.numeric(get_dimension(rectangles$dimensions, 1))
rectangles$ydim <- as.numeric(get_dimension(rectangles$dimensions, 2))
rectangles <- rectangles[-c(1:4)]

# initialize grid and overlap counter
grid <- matrix(rep(0, times = 1000000), nrow = 1000, ncol = 1000)
overlaps <- 0

# parsed_rectangles will contain cleaned up specs as dataframe entries
for (row in 1:nrow(rectangles)) {
  for (x in (rectangles[row, "xpos"]+1):(rectangles[row, "xpos"] + rectangles[row, "xdim"])) {
     for (y in (rectangles[row, "ypos"]+1):(rectangles[row, "ypos"] + rectangles[row, "ydim"])) {
       grid[y,x] <- (grid[y,x] + 1)
       if (grid[y,x] == 2) { overlaps <- (overlaps + 1) }
     }
   }
}

print(overlaps)
