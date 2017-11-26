
library(dplyr)

setwd("C:/Users/Lenovo/Desktop/r_exe/GTD_Proj")

#read train files
d_tr<-read.table("./train/X_train.txt")
y_tr<-read.table("./train/y_train.txt")
subj_id_train<-read.table("./train/subject_train.txt")

#read test files
d_tst<-read.table("./test/X_test.txt")
y_tst<-read.table("./test/y_test.txt")
subj_id_test<-read.table("./test/subject_test.txt")

#read features list
features_list<-read.table("./features.txt",stringsAsFactors = FALSE)
names(d_tr)<-features_list$V2
names(d_tst)<-features_list$V2

#build test and train data
train<-cbind(rep("train",dim(y_tr)[1]),subj_id_train,y_tr,d_tr)
test<-cbind(rep("test",dim(y_tst)[1]),subj_id_test,y_tst,d_tst)

#set data header
names(train)<-c("sample","id","activity_id",names(d_tr))
names(test)<-c("sample","id","activity_id",names(d_tst))

#merge train  and test data
full_data<-rbind(train,test)

#Extracts only the measurements on the mean and standard deviation for each measurement
full_data_new<-full_data[c("sample","id","activity_id",grep("[Ss]td|[Mm]ean",names(d_tr),value = TRUE))]

full_data_new<-merge(full_data_new,activity_labels,by.x="activity_id",by.y="V1")
names(full_data_new)[names(full_data_new)=="V2"]<-"activity_name"

#Appropriately labels the data set with descriptive variable names

names(full_data_new)<-gsub("-"," ",names(full_data_new))
names(full_data_new)<-gsub("\\()","",names(full_data_new))
names(full_data_new)<-gsub("^f|^^t","",names(full_data_new))
names(full_data_new)<-gsub("BodyBody","Body",names(full_data_new))
names(full_data_new)<-gsub(","," ",names(full_data_new))
names(full_data_new)<-gsub("angle\\(","angle ",names(full_data_new))
names(full_data_new)<-gsub("\\)","",names(full_data_new))
  
#Create tidy dataset
names(full_data_new)<-make.names(names(full_data_new),unique=TRUE)
tidy_full_data<-tbl_df(full_data_new)
tidy_full_data<-tidy_full_data%>%select(-matches("sample|activity_id"))%>%
  group_by(id,activity_name)%>%summarise_each(funs(mean))
    
