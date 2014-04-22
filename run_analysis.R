run_analysis <- function( ){
  #Read in Feature List
  featuresTable<-read.table("UCI HAR Dataset/features.txt",col.names=c("id","feature"))
  features<-as.character(featuresTable$feature)
  
  #Read in Test data and merge into singular Data Frame
  x_test<-read.table("UCI HAR Dataset/test/X_test.txt")
  y_test<-read.table("UCI HAR Dataset/test/y_test.txt")
  subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
  TestDF<-cbind(subject_test,y_test,x_test)
  
  #Read in Train data and merge into singular Data Frame
  x_train<-read.table("UCI HAR Dataset/train/X_train.txt")
  y_train<-read.table("UCI HAR Dataset/train/y_train.txt")
  subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
  TrainDF<-cbind(subject_train,y_train,x_train)
  
  #Combined Test and Train Data
  OverallData<-rbind(TestDF,TrainDF)
  
  #Gave OverallData corresponding column names
  colnames(OverallData)<-c("Subject_ID","Activity_ID",features)
  
  #Extract only columns with mean() and std()
  new_OverallData<-OverallData[c("Subject_ID","Activity_ID",grep("(mean\\(\\)|std\\(\\))",names(OverallData),value=TRUE))]
  
  #Read in Activity List
  activities<-read.table("UCI HAR Dataset/activity_labels.txt",col.names=c("Activity_ID","Activity"))
  
  #Join Activity Data Frame with Overall Data
  OverallDataActivities<-merge(activities,new_OverallData,by='Activity_ID',all.x=TRUE)[,-c(1)]

  #Reorder Data Frame to have Subject_ID first
  OverallDataReordered<-OverallDataActivities[,c(2,1,3:length(OverallDataActivities))]
  
  #Order Data Frame based off Subject_ID
  SubjectOrderData<-OverallDataReordered[order(OverallDataReordered$Subject_ID),]

  #Rename Feature Labels to be more descriptive
  names(SubjectOrderData)<-gsub("tBody","Time_Domain_Body",names(SubjectOrderData))
  names(SubjectOrderData)<-gsub("fBody","Frequency_Domain_Body",names(SubjectOrderData))
  names(SubjectOrderData)<-gsub("tGravity","Time_Domain_Gravity",names(SubjectOrderData))
  names(SubjectOrderData)<-gsub("fGravity","Frequency_Domain_Gravity",names(SubjectOrderData))
  names(SubjectOrderData)<-gsub("Acc","_Accelerometer",names(SubjectOrderData))
  names(SubjectOrderData)<-gsub("Jerk","_Jerk",names(SubjectOrderData))
  names(SubjectOrderData)<-gsub("Gyro","_Gyroscope",names(SubjectOrderData))
  names(SubjectOrderData)<-gsub("Mag","_Magnitude",names(SubjectOrderData))
  names(SubjectOrderData)<-gsub("BodyBody","Body_Body",names(SubjectOrderData))
  names(SubjectOrderData)<-gsub("-","_",names(SubjectOrderData))
  names(SubjectOrderData)<-gsub("std\\(\\)","Standard_Deviation",names(SubjectOrderData))
  names(SubjectOrderData)<-gsub("mean\\(\\)","Mean",names(SubjectOrderData))
  
  #Average of Each Variable according to Subject_ID and Activity
  AvgMeasurements<-aggregate(SubjectOrderData[,3:length(SubjectOrderData)],list(Subject_ID=SubjectOrderData$Subject_ID,Activity=SubjectOrderData$Activity),mean)
  AvgMeasurements<-AvgMeasurements[order(AvgMeasurements$Subject_ID),]
}