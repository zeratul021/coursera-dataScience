# Getting and Cleaning Data - Couse Project Code Book

First of all - if you really want to use this dataset you have to read the **[README.txt](UCI HAR Dataset/README.txt)** file from the 3rd party dataset distribution zip. From there you can navigate rest of the documentation egarding the data from the experiment. Complete information can be also found on the [research page](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

Thsi code book doesn't copy-paste the variable/feature names from the original manual. It descriebs transformation on the dataset and it's metadata (like morphing the naming conventions to play nicely with R).

## Analysis description
When using the [run_Analysis.R] main script, always follow the comments in the source code and cross-reference with this code book.
### Prologue
This part covers environment checkup, library and data loading. Soem files are quite big so optionalyl you might wanna clean your workspace memory when you create *allData* data frame for the first time.

I put some logical asserts/preconditions mostly in this part to check for the dimensional consistency fo hte laoded data. Anyone working with matrices will understand this sentiment.

Also I believe in the self documenting code and thus I name the variables quite descriptively based on the business domain. Thus I'm gonna describe soem of them in the text if I believe they deserve explanation and wil lspare the reader of the obvious copy-paste docs.

### Chapter 1
With all the data in the memory we first bind the three **train** data frames together. Then in a same way we bind the three **test** data frames together. And right after that we bind these two together for the main **allData* data frame. Now would be the time to free those 8 variables that you used to get here and don't need anymore.

Now comes the magic with the name transformation. Loaded Feature names contain "illegal characters". So we use nested **gsub** to lose them with htese rules:

* remove empty parenthesis **()** (they look like no-arg function calls)
* replace **-** and **,** and **(** and **)** with **_**

These normalized feature names are stored in **normalizedFeatureNames** and then combined with *subject* and *activity* in the final **allColumnNames** and then applied to the **allData** data frame.

### Chapter 2
Here we do the projection to the columns that contain means and standard deviations (SDs). With the help of dplyr's **select** we keep these columns along with the *subject* and *activity*.

### Chapter 3
Now with the help of dplyr's **mutate** we replace the activity code in *activity* column with it's stringular value from the *activityLabels* data frame. Thsi was a headache to do - until I found the match function. For reasons unknown to me, the commented line above the call wouldn't work.

### Chapter 4
This was done in the [#Chapter 1] when we transformed the feature names to conform to R.

### Chapter 5
Finally with the help of dplyr's **group_by** and **summarise** function we pipieline the data through this call and get means for each column that remained for each person and each activity. That is 88 variables left for 30 subjects times 6 activities all inside the **allDataMeans** variable.

### Epilogue
We print the hardcover book and get the money (from the **allDataMeans** variable).