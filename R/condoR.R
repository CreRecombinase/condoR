


csv_callback <- function(x,pos,key_colname,value_colname){
  csv_cols <- colnames(x)
  non_cap_cols_i <- (which(csv_cols!=toupper(csv_cols))[1]):length(csv_cols)
  cap_cols_i <- 1:(non_cap_cols_i[1]-1)
  cap_cols <- csv_cols[cap_cols_i]
  non_cap_cols <-csv_cols[non_cap_cols_i]
  new_x <- gather_(x,key_col=key_colname,value_col = value_colname,gather_cols=non_cap_cols) %>% filter(Found!="0")
  return(new_x)
}

#' Read a really big dataframe
#' @param csvfile the name of the .csv file (it can also be compressed, so something like file.csv.gz will work too)
#' @param key_colname This is the name for the new "key" column that will be generated, it refers to the non-capitalized columns in the csv
#' @param value_colname This is the column for the non-zero values (they're mostly '1', but occasionally X).  It's left to the user to figure out how to deal with these
#' @param chunksize The number of rows to read at a time. The default is really small. If you make it bigger it will go faster, but if you make it too big, your computer will die
#' @param delim default is " " for space delimited.  If you use tabs use "\t", for commas, use ","
read_big_data <- function(csvfile,key_colname="Bird",value_colname="Found",chunksize=100,delim=" "){
  library(tidyr)
  library(readr)
  library(dplyr)
  if(!file.exists(csvfile)){
    stop(paste0("I couldn't find the file ",csvfile,"so I have to quit"))
    }
  #First we read the first line
  ncsv_callback <- function(x,pos){
  return(csv_callback(x,pos,key_colname=key_colname,value_colname=value_colname))
  }
  options("readr.num_columns" = 0)
  csvd <- read_delim_chunked(file = csvfile,
                             delim = delim,callback = DataFrameCallback$new(ncsv_callback),
                             chunk_size = chunksize,progress=interactive(),)
  return(csvd)
}
