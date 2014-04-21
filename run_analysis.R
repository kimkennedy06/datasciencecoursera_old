run_analysis <- function( ){

  #Read in Test data and merge into singular Data Frame
  x_test<-read.table("UCI HAR Dataset/test/X_test.txt")
  y_test<-read.table("UCI HAR Dataset/test/y_test.txt")
  subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
  TestDF<-cbind(x_test,y_test,subject_test)
  
  #Read in Train data and merge into singular Data Frame
  x_train<-read.table("UCI HAR Dataset/train/X_train.txt")
  y_train<-read.table("UCI HAR Dataset/train/y_train.txt")
  subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
  TrainDF<-cbind(x_train,y_train,subject_train)
  
  features<-read.table("UCI HAR Dataset/features.txt")
  
}