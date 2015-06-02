# Assignment 3
corr <- function(directory, threshold = 0) {
  files <- listFiles(directory)
  res <- c()
  for(f in files) {
    vect <- na.omit(f) 
    if(nrow(vect) > threshold) {
      res <- append(res, cor(vect[ , "sulfate"] ,vect[ ,"nitrate"])
    }    
  }
  if(length(res) == 0) {
    return (res)
  }
  round(res, digits = 4)
}