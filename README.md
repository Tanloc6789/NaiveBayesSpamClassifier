# Naive Bayes Spam Classifier
This is a Basic Binary Naive Bayes Spam Classifier implemented using GNU Octave and Enron email dataset.
Implemented naive bayes spam classifier from scratch using enron email dataset and GNU Octave.The following is the process applied to preprocess the mails :

1.Removing all numeric data and special symbols and following the bag of words model.

2.Removing stop words i.e. a,an,the etc

3.Stemming and lemmaization i.e. playing,played becomes play etc.

After preprocessing the mails,a dictionary is been created using all spam and ham mails,i.e the most appropriate frequently used words in mails have been selected by maintaing a count on each word.


At the time of training,prior,conditional probabilities are calculated and evidence is also calculated.

P(A|B)=(P(B|A)*P(A))/P(B) 


when a new mail is to be tested is is again preprocessed and the word in the testing mail is searched in the training data and its corresponding probabilities are looked and calculated using naive bayes formula,and if prob of that mail being spam given the feature vector is higher than it is classified as spam.

#File Description :

1.NaiveBayesSpamClassifier.m :: A wrapper to call all the helper functions and display the accuracy and confusion matrix of the test data.

2.PreProcessing.m :: A file which takes the raw dataset and preprocesses the mails,and generates training and test dataset.

3.TestingNB.m and TrainNB.m :: A file for testing and training.

4.create_dictionary.m :: Creates dictionary or Bag Of Words model for the Naive Bayes.

5.myconfusionmat.m :: displays the confusion matrix

6.porterStemmer.m and porterStemmer2.m :: used for stemming and lemmaization,porterStemmer2 is optimized version of porterStemmer.

7.stop_words_removal.m :: used for removing stop words while pre processing emails.

8.strjoin.m and subdir.m :: some helper octave files.

For detailed information regarding files,inputs,outputs,look for the comments in the file.

PS : The data used here is stored in dataset_enron,contais 16k ham and 17k spam messages. 

PPS : This is implemented just for learning purposes dont compare it to the standards.However,optimizations are welcome.
