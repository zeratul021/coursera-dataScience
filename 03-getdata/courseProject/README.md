# Getting and Cleaning Data - Couse Project Readme

This small project prepares the data collected from the accelerometers from the Samsung Galaxy S smartphones.

## Contents of this repostoiry folder

* **[README.md](README.md)** - this file (don't recurse here)
* **[CodeBook.md](CodeBook.md)** - a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called 
* **[run_Analysis.R](run_Analysis.R)** - R script for performing the analysis
* **[allDataMeans.txt](allDataMeans.txt)** -  a tidy data (result coming from the analysis script)

## Usage

Before running the analysis script you need to get the data from the 3rd party:

    wget "https://d396qusza40orc.cloudfront.net/getdata-projectfiles-FUCI HAR Dataset.zip"
    unzip getdata-projectfiles-UCI HAR Dataset.zip

After this the folder *[UCI HAR Dataset](UCI HAR Dataset)* shouldn't be empty anymore and you should be able to run the main **[run_Analysis.R](run_Analysis.R)** script.