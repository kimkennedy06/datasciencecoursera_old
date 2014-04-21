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
  
  OverallData<-rbind(TestDF,TrainDF)
  
  colnames(OverallData)<-c("Subject_ID","Activity_ID",features)
}