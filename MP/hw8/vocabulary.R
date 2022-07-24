vocab = read.csv("F:/University/5_semester/MP/hw8/Vocab.csv")
vocab$sex = factor(vocab$sex)

str(vocab)
print(summary(vocab))

print(paste0("Mean vorabulary: ", mean(vocab$vocabulary)))
print(paste0("Male mean vorabulary: ", mean(vocab$vocabulary[vocab$sex == "Male"])))
print(paste0("Female mean vorabulary: ", mean(vocab$vocabulary[vocab$sex == "Female"])))

# building plot for only Ages
print("Building Ages vocabulary barplot...")
data = with(vocab, tapply(vocabulary, list(education), mean))
names(data) <- paste(names(data), ' years')
barplot(data, beside = TRUE, ylab = "Vocabulary", main = "Vocabulary by ages")

# building plot for Age&Sex
data = with(vocab, tapply(vocabulary, list(sex, education), mean))
barplot(
  data, 
  beside = TRUE,
  main = "Vocabulary by ages and sex",
  col = topo.colors(2), 
  legend.text = rownames(data),
  xlab = 'Education',
  ylab = 'Vocabulary',
)

# testing 20y.o. males and females
maxMale = max(vocab$education[vocab$sex == "Male"])
maxFemale = max(vocab$education[vocab$sex == "Female"])
print(paste0("Testing vocabulary difference between ", maxMale, "year males and ", maxFemale, "year females"))
print(t.test(
  vocab$vocabulary[vocab$sex == "Male" & vocab$education == maxMale],
  vocab$vocabulary[vocab$sex == "Female" & vocab$education == maxFemale]
))

print("Years, presented in this tests: ")
years = sort(unique(vocab$year))
print(years)

minVocabulary = sapply(years, function(year) {
  return(mean(vocab$vocabulary[vocab$education == 0 & vocab$year == year]))
})
otherVocabulary = sapply(years, function(year) {
  return(mean(vocab$vocabulary[vocab$education != 0 & vocab$year == year]))
}) 
plot(
  years, 
  minVocabulary, 
  type = "l", 
  col = 'red', 
  xlab = "Year", 
  ylab = "Vulabulary", 
  main = "Graphics for vocabulary of 0 y.o. and others"
)
lines(years, otherVocabulary, col = 'black')
legend("topright", legend = c("0 year", "Other years"), col = c("red", "black"), lty = c(1, 1))