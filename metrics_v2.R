library(mltest)
library(readxl)

arm_clinical <- read_xlsx("Beyond_Fitzpatrick_annotations_03_25.xlsx", sheet="Arm, Clinical")
arm_generated <- read_xlsx("Beyond_Fitzpatrick_annotations_03_25.xlsx", sheet="Arm, Generated")
face_generated <- read_xlsx("Beyond_Fitzpatrick_annotations_03_25.xlsx", sheet="Face, Generated")
face_clinical <- read_xlsx("Beyond_Fitzpatrick_annotations_03_25.xlsx", sheet="Face, Clinical")

alldata <- rbind(arm_clinical, arm_generated, face_clinical, face_generated)

unique(alldata$Group)

# get predictions and actual to same factor levels
monk_levels <- 1:10
fitzpatrick_levels <- 1:6
alldata$`Monk Predicted` <- factor(alldata$`Monk Predicted`, levels=monk_levels)
alldata$`Monk Actual` <- factor(alldata$`Monk Actual`, levels=monk_levels)
alldata$`Fitzpatrick Predicted` <- factor(alldata$`Fitzpatrick Predicted`, levels=fitzpatrick_levels)
alldata$`Fitzpatrick Actual` <- factor(round(alldata$`Fitzpatrick Actual`), levels=fitzpatrick_levels)

# balanced accuracy according to sklearn definition (mean of class recall's)
f_recalls_fp <- function (v_data)
{
  v_data
  return (data.frame(cls = 1:6,
             recalls = c(
               sum(v_data$`Fitzpatrick Accuracy`[v_data$`Fitzpatrick Actual`=="1"] == 1) / (sum(v_data$`Fitzpatrick Accuracy`[v_data$`Fitzpatrick Actual`=="1"] == 1) + sum(v_data$`Fitzpatrick Accuracy`[v_data$`Fitzpatrick Actual`=="1"] == 0)),
               sum(v_data$`Fitzpatrick Accuracy`[v_data$`Fitzpatrick Actual`=="2"] == 1) / (sum(v_data$`Fitzpatrick Accuracy`[v_data$`Fitzpatrick Actual`=="2"] == 1) + sum(v_data$`Fitzpatrick Accuracy`[v_data$`Fitzpatrick Actual`=="2"] == 0)),
               sum(v_data$`Fitzpatrick Accuracy`[v_data$`Fitzpatrick Actual`=="3"] == 1) / (sum(v_data$`Fitzpatrick Accuracy`[v_data$`Fitzpatrick Actual`=="3"] == 1) + sum(v_data$`Fitzpatrick Accuracy`[v_data$`Fitzpatrick Actual`=="3"] == 0)),
               sum(v_data$`Fitzpatrick Accuracy`[v_data$`Fitzpatrick Actual`=="4"] == 1) / (sum(v_data$`Fitzpatrick Accuracy`[v_data$`Fitzpatrick Actual`=="4"] == 1) + sum(v_data$`Fitzpatrick Accuracy`[v_data$`Fitzpatrick Actual`=="4"] == 0)),
               sum(v_data$`Fitzpatrick Accuracy`[v_data$`Fitzpatrick Actual`=="5"] == 1) / (sum(v_data$`Fitzpatrick Accuracy`[v_data$`Fitzpatrick Actual`=="5"] == 1) + sum(v_data$`Fitzpatrick Accuracy`[v_data$`Fitzpatrick Actual`=="5"] == 0)),
               sum(v_data$`Fitzpatrick Accuracy`[v_data$`Fitzpatrick Actual`=="6"] == 1) / (sum(v_data$`Fitzpatrick Accuracy`[v_data$`Fitzpatrick Actual`=="6"] == 1) + sum(v_data$`Fitzpatrick Accuracy`[v_data$`Fitzpatrick Actual`=="6"] == 0))
             )))
}
f_recalls_monk <- function(v_data)
{
  return (data.frame(cls = 1:10,
                     recalls = c(
                       sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="1"] == 1) / (sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="1"] == 1) + sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="1"] == 0)),
                       sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="2"] == 1) / (sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="2"] == 1) + sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="2"] == 0)),
                       sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="3"] == 1) / (sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="3"] == 1) + sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="3"] == 0)),
                       sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="4"] == 1) / (sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="4"] == 1) + sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="4"] == 0)),
                       sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="5"] == 1) / (sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="5"] == 1) + sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="5"] == 0)),
                       sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="6"] == 1) / (sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="6"] == 1) + sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="6"] == 0)),
                       sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="7"] == 1) / (sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="7"] == 1) + sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="7"] == 0)),
                       sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="8"] == 1) / (sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="8"] == 1) + sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="8"] == 0)),
                       sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="9"] == 1) / (sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="9"] == 1) + sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="9"] == 0)),
                       sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="10"] == 1) / (sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="10"] == 1) + sum(v_data$`Monk Accuracy`[v_data$`Monk Actual`=="10"] == 0))
                     )))
}
# recalls per class for all groups
recalls_fp <- f_recalls_fp(alldata)
recalls_monk <- f_recalls_monk(alldata)

# recalls per group
recalls_fp_arm <- f_recalls_fp(alldata[alldata$Group == 'Arm',])
recalls_fp_arm_g <- f_recalls_fp(alldata[alldata$Group == 'Arm, generated',])
recalls_fp_face <- f_recalls_fp(alldata[alldata$Group == 'Face',])
recalls_fp_face_g <- f_recalls_fp(alldata[alldata$Group == 'Face, generated',])

recalls_monk_arm <- f_recalls_monk(alldata[alldata$Group == 'Arm',])
recalls_monk_arm_g <- f_recalls_monk(alldata[alldata$Group == 'Arm, generated',])
recalls_monk_face <- f_recalls_monk(alldata[alldata$Group == 'Face',])
recalls_monk_face_g <- f_recalls_monk(alldata[alldata$Group == 'Face, generated',])

bal_accuracy <- data.frame(
  group = c('Arm Monk', 'Arm generated Monk', 'Face Monk', 'Face generated Monk', 
            'Arm FP', 'Arm generated FP', 'Face FP', 'Face generated FP')
)
bal_accuracy$balanced_accuracy <- c(mean(na.omit(recalls_monk_arm$recalls)),
                                    mean(na.omit(recalls_monk_arm_g$recalls)),
                                    mean(na.omit(recalls_monk_face$recalls)),
                                    mean(na.omit(recalls_monk_face_g$recalls)),
                                    mean(na.omit(recalls_fp_arm$recalls)),
                                    mean(na.omit(recalls_fp_arm_g$recalls)),
                                    mean(na.omit(recalls_fp_face$recalls)),
                                    mean(na.omit(recalls_fp_face_g$recalls)))
write.csv(bal_accuracy, file="balanced_accuracy_ouraccuracy_sklearn.csv")


# metrics per class
mltest_monk <- ml_test(alldata$`Monk Predicted`, alldata$`Monk Actual`)
mltest_fp <- ml_test(alldata$`Fitzpatrick Predicted`, alldata$`Fitzpatrick Actual`)

sufficient_accuracy_monk <- data.frame( cls = 1:10, 
                                sufficient_accuracy = c(
                               mean(alldata$`Monk Sufficient Accuracy`[alldata$`Monk Actual` == "1"]),
                               mean(alldata$`Monk Sufficient Accuracy`[alldata$`Monk Actual` == "2"]),
                               mean(alldata$`Monk Sufficient Accuracy`[alldata$`Monk Actual` == "3"]),
                               mean(alldata$`Monk Sufficient Accuracy`[alldata$`Monk Actual` == "4"]),
                               mean(alldata$`Monk Sufficient Accuracy`[alldata$`Monk Actual` == "5"]),
                               mean(alldata$`Monk Sufficient Accuracy`[alldata$`Monk Actual` == "6"]),
                               mean(alldata$`Monk Sufficient Accuracy`[alldata$`Monk Actual` == "7"]),
                               mean(alldata$`Monk Sufficient Accuracy`[alldata$`Monk Actual` == "8"]),
                               mean(alldata$`Monk Sufficient Accuracy`[alldata$`Monk Actual` == "9"]),
                               mean(alldata$`Monk Sufficient Accuracy`[alldata$`Monk Actual` == "10"])))

sufficient_accuracy_fp <- data.frame( cls = 1:6, 
                           sufficient_accuracy = c(
                             mean(na.omit(alldata$`Fitzpatrick Sufficient Accuracy`[alldata$`Fitzpatrick Actual` == "1"])),
                             mean(na.omit(alldata$`Fitzpatrick Sufficient Accuracy`[alldata$`Fitzpatrick Actual` == "2"])),
                             mean(na.omit(alldata$`Fitzpatrick Sufficient Accuracy`[alldata$`Fitzpatrick Actual` == "3"])),
                             mean(na.omit(alldata$`Fitzpatrick Sufficient Accuracy`[alldata$`Fitzpatrick Actual` == "4"])),
                             mean(na.omit(alldata$`Fitzpatrick Sufficient Accuracy`[alldata$`Fitzpatrick Actual` == "5"])),
                             mean(na.omit(alldata$`Fitzpatrick Sufficient Accuracy`[alldata$`Fitzpatrick Actual` == "6"]))
                           ))
metrics_monk <- data.frame(cls = 1:10, 
                           recall_sufficient_accuracy=sufficient_accuracy_monk$sufficient_accuracy,
                           recall_accuracy=recalls_monk$recalls)
metrics_fp <- data.frame(cls = 1:6, 
                         recall_sufficient_accuracy=sufficient_accuracy_fp$sufficient_accuracy,
                         recall_accuracy=recalls_fp$recalls)

write.csv(metrics_monk, file="metrics_monk.csv", row.names = FALSE)
write.csv(metrics_fp, file="metrics_fp.csv", row.names = FALSE)
