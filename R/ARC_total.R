## Function: ARC_total()
#### N = Total Items Recalled (length of recall correct vector, 0's and 1's)
#### Max = (N - c) when c is the number of categories recalled (will include intrusions: coded as their own category or *even* left blank (i.e. "NA" will count as a category in Max and E(r))
#### HOWEVER: Back-to-back blank cells (NAs) will not count toward repetitions

ARC_total <- function(correct, category) { # correct = vector of 1s/0s indicating a response as correct, category = vector of category indicator

  N = length(correct) # length of recall_correct vector (TOTAL RECALL)

  cat_count <- plyr::count(category) # get category frequency

  c = length(cat_count$freq) # length of category frequency vector (number of categories)

  maxrep = N - c # calculate max for ARC denominator and other measures

  sum_ni_sq = sum(cat_count$freq^2) # get sums of squared number of each category for E(r) numerator

  Erepits = (sum_ni_sq / N) - 1 # compute E(r) (Expected Reps Given Recall N)

  rle_length <- rle(category) # get Run Length Encoding (lengths and values)

  repits = sum(rle_length$lengths - 1) # take lengths (sequence length) and minus 1 for reps, then sum

  BBD = repits - Erepits # Bousfield and Bousfield deviation

  MRR = repits / maxrep # modified ratio of repetition

  ARC = (repits - Erepits) / (maxrep - Erepits) # calculate ARC

  out_list <- list(ARC = ARC, MRR = MRR, BBD = BBD, Total_N = N, Repetitions = repits,
                   Max = maxrep, Er = Erepits)

  return(out_list)

}


