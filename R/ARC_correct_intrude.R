## Function: ARC_correct_intrude()
#### N = Correct Items Recalled (sum of recall correct 1's)
#### Adjusted Max = N - c when c is the number of *correct* categories recalled (if intrusions are ALL treated the same (i.e., must be left blank - function adjusts Max to account for that)
#### Back-to-back blank cells (NAs) will not be considered a repetition

ARC_correct_intrude <- function(correct, category) { # correct = vector of 1s/0s indicating a response as correct, category = vector of category indicator

  `%>%` <- magrittr::`%>%`

  N = sum(correct) # length of recall_correct vector (TOTAL RECALL)

  cat_count <- plyr::count(category) %>% dplyr::filter(!is.na(x)) # get category frequency MINUS blank (NA) categories

  c = length(cat_count$freq) # length of category frequency vector (number of categories)

  maxrep = N - c # calculate max for ARC denominator and other measures

  maxrep_adj = N - c # calculate ADJUSTED max to address intrusion "category" (still N - c because c has been adjusted above to exclude NAs (intrusions))

  sum_ni_sq = sum(cat_count$freq^2) # get sums of squared number of each category for E(r) numerator

  Erepits_adj = (sum_ni_sq / N) - 1 # compute E(r) (Expected Reps Given Recall N)

  rle_length <- rle(category) # get Run Length Encoding (lengths and values)

  repits = sum(rle_length$lengths - 1) # take lengths (sequence length) and minus 1 for reps, then sum

  ARC_adj = (repits - Erepits_adj) / (maxrep_adj - Erepits_adj) # calculate ARC (including intrusions in max)

  out_list <- list(Adjusted_ARC = ARC_adj, Correct_N = N, Repetitions = repits,
                   Adjusted_Max = maxrep_adj, Adjusted_Er = Erepits_adj)

  return(out_list)

}


