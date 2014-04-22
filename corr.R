corr<-function(directory,threshold=0)
{
  #Create new variable with the data frame 
  complete_cases<-complete(directory)
  #Create new variable of the subset of the data frame with nobs greater than the threshold
  threshold<-subset(complete_cases,nobs>threshold)
  #Create threshold_ids and correlations
  threshold_ids<-c()
  correlations<-c()
  #if number of rows in threshold is 0 return the empty vector correlations
  if(nrow(threshold)==0)
  {
    return(correlations)
  }
  else
  {
    #Convert list threshold["id"] to vector
    threshold_ids<-unlist(threshold["id"])
    #Iterate through all ids in threshold_ids
    for(number in threshold_ids)
    {
      #Determine the correct file path
      #If number is 1-9, the filepath is "directory/00<number>.csv      
      if(number>0 && number<10)
      {
        file<-paste(directory,'/00',number,'.csv',sep="",collapse="")
      }
      #If number is 10-99, the filepath is "directory/00<number>.csv
      else if(number>=10 && number<100)
      {
        file<-paste(directory,'/0',number,'.csv',sep="",collapse="")
      }
      #If number is greater than 99, the filepath is "directory/00<number>.csv      
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
      #Create new variable with vector data_complete["nitrate"]  
      nitrates<-unlist(data_complete["nitrate"])
      #Create new variable with vector data_complete["sulfate"]        
      sulfates<-unlist(data_complete["sulfate"])
      #Calculate the correlation between the nitrates and sulfates
      nitrate_sulfate_corr<-cor(nitrates,sulfates)
      #Append calculated correlation to correlaton vector
      correlations<-c(correlations,nitrate_sulfate_corr)
    }
  }
  return(correlations)
}