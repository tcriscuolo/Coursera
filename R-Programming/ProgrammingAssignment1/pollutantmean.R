# Gets a pollutant in a given file
res_file <- function(file, pollutant) {
  f <- read.csv(file)
  f[ , pollutant]
}

# Return a file address according do the dir and id
file_address <- function(dir, id) {
  temp <- ''
  if(id < 10) {
    temp = "00"
  } else if(id < 100) {
    temp = "0"
  }
  paste(dir, "/", temp, id,".csv", sep = "")
}

# Return a list of files according to dir and ids
create_list <- function(dir, id) {
  list <- c()
  for(i in id) {
    address <- file_address(dir, i)
    list <- union(list, address)
  }
  list
}


# Assignment 1
pollutantmean <- function(directory, pollutant, id = 1:332) {
  files_list <- create_list(directory, id)
  res <- c()
  for(file in files_list) {
    res <- append(res, res_file(file, pollutant))
  }
  print(mean(unlist(res), na.rm = TRUE), digits = 4)
}