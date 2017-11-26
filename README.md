# GettingCleaningData_FinalAssignment
the script create a tidy summarized data from the combined samsung train and test sets.</br>
documentation is available at the body of the script.
</br>
first part of the code reads relevant files. then the name of the activities are merged into the file.
feature names are added from the feature list data. then train and test data are combined with cbind command.
</br>
relevant features are extracted by using regular expressions. then column names are labeled by replacing text with the gsub function.
finally, data is grouped and summarized with the relevant verbs from the dplyr package.
</br>


