pollutantmean<-function(directory,pollutant,id=1:332)
{
  #Create pollutant_sum and pollutant_Count variables
  #Initialize variables to 0
  pollutant_Sum<-0
  pollutant_Count<-0
  
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
    #Find all complete_cases in the data for the pollutant
    good<-complete.cases(data[pollutant])
    #Create new variable with only complete_cases in file
    data_pollutant<-data[good,][,]
    #Create new variable with the count of the monitor complete_cases of the pollutant
    monitor_count<-nrow(data_pollutant)
    #Create new variable with the sum of the monitor complete_cases of the pollutant
    monitor_sum<-colSums(data_pollutant[pollutant])
    #Create new variable with the sum of the pollutant complete_cases
    pollutant_Sum<-pollutant_Sum+monitor_sum
    #Create new variable with the count of the pollutant complete_cases
    pollutant_Count<-pollutant_Count+monitor_count
  }
  #Calculate the overall mean for the pollutant for all ids
  pollutant_mean<-pollutant_Sum/pollutant_Count
  return(pollutant_mean)
}