fileIn <- file("311_Service_Requests_from_2010_to_Present.csv","r")

fileOut_createDate <- file("CreateDate.csv","a")
fileOut_agency <- file("Agency.csv","a")
fileOut_complaint <- file("Complaint.csv","a")
fileOut_borough <- file("Borough.csv","a")
fileOut_latitude <- file("Latitude.csv","a")
fileOut_longitude <- file("Longitude.csv","a")

chunk <- readLines(fileIn, n=1)

chunkSize <- 10000
n_chunk <- 1

while(length(chunk)) {
  while (length(grep("\".*?.\"", chunk))){
    chunk <- sub("\".*?.\"", "DontCare",chunk)}
  chunkSep <- strsplit(chunk,",")
  
  CreateDate <- sapply(chunkSep, function(x) x[2])
  AgencyName <- sapply(chunkSep, function(x) x[4])
  Complaint <- sapply(chunkSep, function(x) x[6])
  Borough <- sapply(chunkSep, function(x) x[25])
  Latitude <- sapply(chunkSep, function(x) x[51])
  Longitude <- sapply(chunkSep, function(x) x[52])

  if (length(CreateDate)) writeLines(CreateDate, fileOut_createDate)
  if (length(AgencyName)) writeLines(AgencyName, fileOut_agency)
  if (length(Complaint)) writeLines(Complaint, fileOut_complaint)
  if (length(Borough)) writeLines(Borough, fileOut_borough)
  if (length(Latitude)) writeLines(Latitude, fileOut_latitude)
  if (length(Longitude)) writeLines(Longitude, fileOut_longitude)
  
  chunk <- readLines(fileIn, n=chunkSize)
  
  n_chunk = n_chunk + 1
  print(n_chunk)
}
close(fileIn)
close(fileOut_createDate)
close(fileOut_agency)
close(fileOut_complaint)
close(fileOut_borough)
close(fileOut_latitude)
close(fileOut_longitude)

# What fraction of complaints are associated with the 2nd most popular agency?
# answer: a1 = 0.171327580193882

AgencyFiled <- read.csv("Agency.csv", header=TRUE)
Agencylist <-  unique(AgencyFiled$Agency)
occurance <- NULL
for(j in 1:length(Agencylist)){occurance[j] <- length(grep(Agencylist[j], AgencyFiled$Agency))}
a1 <- as.double(sort(occurance, decreasing = TRUE)[2])/as.double(length(AgencyFiled$Agency))

# What is the distance (in degrees) between the 90% and 10% percentiles of degrees latitude?
# answer: a2 = 0.23574779569951
LatitudeFiled <- read.csv("Latitude.csv", header=TRUE)
LatQuantile <- as.double(quantile(LatitudeFiled$Latitude,c(0.1,0.9)))
a2 <- LatQuantile[2] - LatQuantile[1]

# What is the difference between the expected number of calls received 
# during the most and least popular whole hours of the day? 
# (Remove points which do not seem to accurately reflect the actual time they were reported.)
# a3 = 2081.87831898213
CreateDateFiled <- read.csv("CreateDate.csv", header=TRUE)
CreateDate_formated <- strptime(as.character(CreateDateFiled$Created.Date), "%m/%d/%Y %I:%M:%S %p")
CreateHourFiled <- CreateDate_formated$h
CreateHourList <-  unique(CreateHourFiled)
totDays <- difftime(CreateDate_formated[1],CreateDate_formated[length(CreateDate_formated)],units="days")
totDays <- as.numeric(totDays)
occurance <- NULL
for(j in 1:length(CreateHourList)){occurance[j] <- length(grep(CreateHourList[j], CreateHourFiled))}
a3 <- as.double(sort(occurance, decreasing = TRUE)[1]) - as.double(sort(occurance, decreasing = TRUE)[length(occurance)])
a3 <- a3/totDays

# What is the most 'surprising' complaint type when conditioned on a borough? 
# That is, what is the largest ratio of the conditional probability of a complaint type given a specified borough 
# divided by the unconditioned probability of that complaint type?
ComplaintFiled <- read.csv("Complaint.csv", header=TRUE)
ComplaintList <- unique(ComplaintFiled)
occurance <- NULL
for(j in 1:length(ComplaintList)){occurance[j] <- length(grep(ComplaintList[j], ComplaintFiled))}
ComplaintP <- occurance/length(ComplaintFiled)

BoroughFiled <- read.csv("Borough.csv", header=TRUE)


LongitudeFiled <- read.csv("Longitude.csv", header=TRUE)
