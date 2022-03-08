# setting working directory
setwd(dir = "F:\\warehouse\\study_warehouse\\R\\titanic")

#importing datasets
read.csv("F:\\warehouse\\study_warehouse\\R\\titanic\\train.csv",stringsAsFactors = F)->titanic.train
read.csv("F:\\warehouse\\study_warehouse\\R\\titanic\\test.csv",stringsAsFactors = F)->titanic.test

#exploring data

head(titanic.train)
tail(titanic.train)

str(titanic.test)

median(titanic.train$Age,na.rm = T)
median(titanic.test$Age,na.rm = T)

titanic.train$ISTrainSet<-TRUE
titanic.test$ISTrainSet<-FALSE

ncol(titanic.test)
ncol(titanic.train)

names(titanic.train)
names(titanic.test)

titanic.test$Survived <-NA

titanic.full <- rbind(titanic.train,titanic.test)

nrow(titanic.full)

table(titanic.full$ISTrainSet)

table(titanic.full$Embarked)

titanic.full[titanic.full$Embarked=="","Embarked"]<-'S'

table(titanic.full$Embarked)

table(is.na(titanic.full$Age))

median(titanic.full$Age,na.rm = T)->age.medium

titanic.full[is.na(titanic.full$Age),'Age']<-age.medium

table(is.na(titanic.full$Fare))

median(titanic.full$Fare,na.rm = T)->fare.medium

titanic.full[is.na(titanic.full$Fare),'Fare']<-fare.medium

table(is.na(titanic.full$Fare))

#spliting dataset
titanic.train<-titanic.full[titanic.full$ISTrainSet==TRUE,]

tail(titanic.train)

titanic.test<-titanic.full[titanic.full$ISTrainSet==FALSE,]

head(titanic.test)

#categorical casting

table(titanic.full$Survived)

str(titanic.full)

#converting data type
as.factor(titanic.full$Pclass)->titanic.full$Pclass
as.factor(titanic.full$Sex)->titanic.full$Sex
as.factor(titanic.full$Embarked)->titanic.full$Embarked
as.factor(titanic.train$Survived)->titanic.train$Survived

#buliding model
Survived.eqution<-"Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked"
as.formula(Survived.eqution)->survived.formula

library(randomForest)

randomForest(formula = survived.formula,data=titanic.train,ntree=500,mtry=3,nodesize=0.01*nrow(titanic.test))->titanic.model

feature.equation<- "Pclass + Sex + Age + SibSp + Parch + Fare + Embarked"

predict(titanic.model,newdata = titanic.test)->survived

PassengerId<-titanic.test$PassengerId
as.data.frame(PassengerId)
output.df<-as.data.frame(PassengerId)
output.df$survived<-survived

head(output.df)

write.csv(output.df,file = "kaggle_submission.csv",row.names = FALSE)





























