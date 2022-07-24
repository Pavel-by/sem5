mtable = data.frame(
  name = c("John Davis", "Angela Williams", "Janice Markhammer", "Bullwinkle Moose", "Mary Rayburn", "Greg Knox"),
  sex = factor(c("Male", "Female", "Female", "Male", "Female", "Male"), levels = c("Male", "Female")),
  age = c(21, 23, 40, 35, 18, 20),
  education = factor(c("Secondary", "Higher", "-", "Secondary", "Secondary", "Higher")),
  income = c(125, 345, 50, 399, 136, 120)
)

print(paste0("Sex: ", class(mtable$sex)))
print(paste0("Education: ", class(mtable$education)))

mtable["income_20"] <- mtable$income * 1.2

print(paste0("Medium income: ", mean(mtable$income)))
barplot(height = mtable$income, names.arg = mtable$age, xlab = "Age", ylab = "Income")

mtable["income_S"] <- mtable$income + mtable$income_20

maxIncome <- max(mtable$income)
mtable["income_M"] <- mtable$income / maxIncome * 100

print(paste0("Male mean income: ", mean(mtable$income[mtable$sex == "Male"])))
print(paste0("Female mean income: ", mean(mtable$income[mtable$sex == "Female"])))

mtable$income_20 <- NULL