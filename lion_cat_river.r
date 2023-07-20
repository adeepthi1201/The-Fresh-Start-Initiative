# DEFINE THE FRESH START INITIATIVE
# The Fresh Start Initiative is a comprehensive program that focuses on helping incarcerated individuals re-enter the workforce. The program provides job training, employment counseling, and job placement services to individuals leaving prison or jail. 

# CODE

#1. Load necessary packages
library(lubridate)
library(dplyr)

#2. Set up environment
setwd("directory/TheFreshStartInitiative/")

#3. Read in data 
trainees <- read.csv("TraineeData.csv", stringsAsFactors = F)

#4. Convert Date of Birth to Date Time 
trainees$DOB <- mdy(trainees$DOB)

#5. Calculate trainee age
trainees$Age <- years(trainees$DOB, Sys.Date())

#6. Create a flag for trainees under 18
trainees$under18 <- ifelse(trainees$Age < 18, "Y", "N")

#7. Remove columns we don't need
trainees <- select(trainees, -DOB,-Age)

#8. Select only trainees over 18
trainees <- filter(trainees, under18 == "N")

#9. Create a new dataframe for trainees' skills
skills <- trainees %>%
  select(Id, Skill_1, Skill_2, Skill_3, Skill_4)

#10. Reformat skill items into a single column
skills <- skills %>%
  gather("Skill", "Skill_Name", Skill_1: Skill_4)

#11. Remove rows with missing values
skills <- na.omit(skills)

#12. Create a dummy variable to represent skill level
skills <- skills %>%
  mutate(Skill_Level = ifelse(Skill_Name == "None", 0, 1))

#13. Sum the skill levels for each trainee 
skill_level_sum <- skills %>%
  group_by(Id) %>%
  summarise(Sum_Skills = sum(Skill_Level))

#14. Join skill levels with trainee info
trainees <- left_join(trainees, skill_level_sum, by="Id")

#15. Create a dummy variable to represent if trainee has any skills
trainees$Skilled <- ifelse(trainees$Sum_Skills > 0, "Y", "N")

#16. Create a flag for trainees with no job experience
trainees$recent_job <- ifelse(trainees$Recent_Work_Experience == "N", "Y", "N")

#17. Create a dummy variable for trainees with no job experience
trainees$NoJob <- ifelse(trainees$recent_job == "Y", 1, 0)

#18. Calculate the average job score for each trainee
job_score <- trainees %>%
  summarise(avg_score = mean(Overall_Job_Score, na.rm = TRUE))

#19. Join job score with trainee info
trainees <- left_join(trainees, job_score, by = "Id")

#20. Scale job scores to range from 0 to 1
scaled_scores <- scale(trainees$avg_score, center = T, scale = T)

#21. Replace the job scores with the scaled values
trainees$avg_score <- scaled_scores

#22. Create a dummy variable to represent job score level
trainees$JobScore <- ifelse(trainees$avg_score >= 0.5, "High", "Low")

#23. Read in job postings
postings <- read.csv("JobPostings.csv", stringsAsFactors = F)

#24. Convert job posting dates to Date Time
postings$Start_Date <- mdy(postings$Start_Date)

#25. Calculate the difference in days between trainee start date and job posting
trainees$DateDiff <- days(trainees$Start_Date, postings$Start_Date)

#26. Create a dummy variable to represent if job postings are within 10 days
trainees$RecentPostings <- ifelse(trainees$DateDiff <= 10, "Y", "N")

#27. Create a dummy variable to represent if trainees signed up for job alerts
trainees$JobAlert <- ifelse(trainees$Job_Alerts == "Y", 1, 0)

#28. Create a flag for trainees with no current job
trainees$CurrJob <- ifelse(trainees$Current_Job == "N", "Y", "N")

#29. Read in job offers
offers <- read.csv("JobOffers.csv", stringsAsFactors = F)

#30. Convert job offer dates to Date Time
offers$OfferDate <- mdy(offers$OfferDate)

#31. Calculate the difference in days between trainee start date and job offer
trainees$OfferDiff <- days(trainees$Start_Date, offers$OfferDate)

#32. Create a dummy variable to represent if job offers are within 14 days
trainees$RecentOffers <- ifelse(trainees$OfferDiff <= 14, "Y", "N")

#33. Create a dummy variable to represent if trainees accepted job offers
trainees$AcceptOffers <- ifelse(trainees$Job_Offers == "Y", 1, 0)

#34. Read in job placements 
placements <- read.csv("JobPlacements.csv", stringsAsFactors = F)

#35. Convert job placement dates to Date Time
placements$PlacementDate <- mdy(placements$PlacementDate)

#36. Calculate the difference in days between trainee start date and job placement
trainees$PlacementDiff <- days(trainees$Start_Date, placements$PlacementDate)

#37. Create a dummy variable to represent if job placements are within 30 days
trainees$RecentPlacements <- ifelse(trainees$PlacementDiff <= 30, "Y", "N")

#38. Create a dummy variable to represent if trainees secured job placements
trainees$SecurePlacements <- ifelse(trainees$Job_Placement == "Y", 1, 0)

#39. Read in job retention
retention <- read.csv("JobRetention.csv", stringsAsFactors = F)

#40. Convert job retention dates to Date Time
retention$RetentionDate <- mdy(retention$RetentionDate)

#41. Calculate the difference in days between trainee start date and job retention
trainees$RetentionDiff <- days(trainees$Start_Date, retention$RetentionDate)

#42. Create a dummy variable to represent if job retainment is within 6 months
trainees$RecentRetention <- ifelse(trainees$RetentionDiff <= 180, "Y", "N")

#43. Create a dummy variable to represent if trainees kept jobs
trainees$SecureRetention <- ifelse(trainees$Job_Retention == "Y", 1, 0)

#44. Read in program exit surveys
exit_surveys <- read.csv("ExitSurveys.csv", stringsAsFactors = F)

#45. Convert program exit dates to Date Time
exit_surveys$ExitDate <- mdy(exit_surveys$ExitDate)

#46. Calculate the difference in days between trainee start date and program exit
trainees$ExitDiff <- days(trainees$Start_Date, exit_surveys$ExitDate)

#47. Create a dummy variable to represent if program exits are within 6 months
trainees$RecentExit <- ifelse(trainees$ExitDiff <= 180, "Y", "N")

#48. Create a dummy variable to represent if trainees completed program
trainees$CompleteProgram <- ifelse(trainees$Program_Exit == "Y", 1, 0)

#49. Create a flag for trainees with financial need
trainees$FinancialNeed <- ifelse(trainees$Financial_Assistance == "Y", "Y", "N")

#50. Create a dummy variable to represent financial need 
trainees$FinNeed <- ifelse(trainees$FinancialNeed == "Y", 1, 0)

#51. Summarize the data
summary <- trainees %>%
  group_by(Skilled, JobScore, RecentPostings, RecentOffers, RecentPlacements, RecentRetention, RecentExit) %>%
  summarise(NoJob = sum(NoJob),
            JobAlert = sum(JobAlert, na.rm = TRUE),
            AcceptOffers = sum(AcceptOffers, na.rm = TRUE),
            SecurePlacements = sum(SecurePlacements, na.rm = TRUE),
            SecureRetention = sum(SecureRetention, na.rm = TRUE),
            CompleteProgram = sum(CompleteProgram, na.rm = TRUE),
            FinNeed = sum(FinNeed, na.rm = TRUE))

#52. Save summary data to csv file
write.csv(summary, file = "SummaryData.csv")