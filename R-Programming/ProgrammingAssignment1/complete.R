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



# Return the number of complete test in a given file
complete_cases <- function(dir, id) {
  address <- (file_address(dir, id))
  f <- read.csv(address)
  f <- na.omit(f)
  nrow(f)
}

# Assignment 2
complete <- function(directory, id = 1:132) {
  result <- matrix(nrow = length(id), ncol = 2)
  v <- 1
  for(i in id) {
    r <- complete_cases(directory, i)
    result[v, 1] = i
    result[v, 2] = r
    v <- v + 1
  } 
  colnames(result) <- c("id", "nobs")
  result <- data.frame(result)
  result
}

