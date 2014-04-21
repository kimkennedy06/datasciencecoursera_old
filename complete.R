complete<-function(directory,id=1:332)
{
  #Create pollutant_sum and pollutant_Count variables
  #Initialize variables to 0
  pollutant_Sum<-0
  pollutant_Count<-0
  #Create an empty vector for nobs
  nobs<-vector("integer")
  #iterate through all numbers in id variable
  for(number in id)
  {
    #Determine the correct file path
    #If number is 1-9, the filepath is "directory/00<number>.csv
    if(number>0 && number<10)
    {
      file<-paste(directory,'/00',number,'.csv',sep="",collapse="")
    }
    #If number is 10-99, the filepath is "directory/0<number>.csv    
    else if(number>=10 && number<100)
    {
      file<-paste(directory,'/0',number,'.csv',sep="",collapse="")
    }
    #If number is greater than 99, the filepath is "directory/<number>.csv    
    else
    {
      file<-paste(directory,'/',number,'.csv',sep="",collapse="")
    }
    #Read the file    
    data<-read.csv(file)
    #Find all complete_cases in the data    
    good<-complete.cases(data)
    #Create new variable with only complete_cases in file    
    data_complete<-data[good,][,]
    #Create new variable with the count of the monitor complete_cases    
    monitor_count<-nrow(data_complete)
    #Append monitor count results to nobs
    nobs<-c(nobs,monitor_count)
  }
  #create data frame with the ids and nobs
  complete_cases<-data.frame(id,nobs)
  return(complete_cases)
}