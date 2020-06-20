# MemoryOrg
A Minimal R Package Dedicated to Quantifying Retrieval Organization (A Few Ways)

## What the Package Does and Why

Computes Adjusted Ratio of Clustering (ARC), Paired Frequency (PF), and the Shared Organization Metric Analysis (SOMA)

**ARC** (Roenker et al. 1971)...(More on the measure, what it does, and why it is important)

**PF** (Sternberg & Tulving, 1977)...(More on the measure, what it does, and why it is important)

**SOMA** (Congleton & Rajaram, 2014)...(More on the measure, what it does, and why it is important)

## Getting Started

As MemoryOrg is hosted on Github, you can use devtools to install. If you don't have it already, you'll need to install.
```r
install.packages("devtools")
library(devtools)
install_github("ggreeley/MemoryOrg")
library(MemoryOrg)
```

# ARC
Each ARC function takes two arguments: a vector of 1's and 0's that indicate if a response (recalled word) was correct, and a vector containing the category of the word recalled. This category code can be a single letter (like below), numeric (e.g., fruit = 1), or simply the category name (e.g., FRUIT) - as long as it's consistent. This data can be manually entered (like the example) or, more likely, read-in as a recall protocol. That is, a CSV or similar file with the output of a participant (cleaned appropriately). See the ARC example data and specific function documentation for formatting, which is especially important if intrusions are present.

**ARC_correct**  
```r
recall_correct <- c(1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1) # correct/incorrect
recall_category <- c("a","a", NA ,"a","a","b","a","c","b","b","b","b","c","b","c","c","c","c") # corresponding categories

ARC_correct(recall_correct, recall_category)
```

**ARC_total**  
```r
ARC_total(recall_correct, recall_category)
```

**ARC_correct_intrude**  
```r
ARC_correct_intrude(recall_correct, recall_category)
```

**ARC_total_intrude**  
```r
ARC_total_intrude(recall_correct, recall_category)
```

A few important things to note: 

Back-to-back NA's *do not* count toward repetitions (even if NA's are being counted as a category as they are in ARC_total and ARC_correct). Thus, if you want to measure clustering of intrusions, code them rather than leaving them blank. 

Additionally, "correct" and "total" in the functions refer to the vector indicating correct/incorrect responses. This will impact the N in Max and E(r) calculations (see documentation and note the different results with the same data). 

Finally, functions containing "intrude" don't count blank NA values as a category, though ARC_total_intrude will still count them toward N. Both "intrude" functions, then, do not count NA values toward the E(r) numerator.

Moral of the story: in most real applications (intrusions present, interest in clustering of correct words) - ARC_correct_intrude is likely the best bet.

# PF 
Each PF function takes two arguments: a vector of words (recall output) and... another vector of words (another recall output). PF assess the number of forward and backward pairs of items from recall trial X to recall trial X+1. Really, any two outputs can be compared, but that is the classic approach. Just as with ARC, reading-in a CSV or similar file with the output of a participant (cleaned appropriately) is also possible - see example data.

The only difference between the two PF functions is that PF_all produces the componet measures (number of common items, number of observed pairs, etc.) while PF produces only PF.

**PF_all**  
```r
recall_1 <- c("king", "palace", "forest", "poem") # recall output (e.x., recall 1)
recall_2 <- c("walnut", "sorrow", "mountain", "game", "forest", "poem") # another recall output (e.x., recall 2)

PF_all(recall_1, recall_2)
```

**PF**
```r
PF(recall_1, recall_2)
```

One important thing to note: 

Blank (NA) values (not shown in example above, but see example data) will *not* count toward a pair. Thus, if you want intrusions to count, simply leave them in the protocol. If you don't want intrusions to count, and want them to break pairs of words, remove the word and leave an empty cell.

# SOMA
Both SOMA functions take three arguments: a vector of words (recall output), another vector of words (another recall output), and...another vector of words (another recall output). Computationally equivalent to PF, but with a key difference in motivation, SOMA assesses the number of forward and backward pairs of items **across multiple individuals**. That is, it is a measure of shared organization.  Specifically, these functions handle triads (i.e., responses of three individuals). SOMA_all produces dyad level SOMA and measurements, but if just two individuals are being compared, you should just use PF_all or PF. Just as with ARC and PF, reading-in a CSV or similar file with the output of a participant (cleaned appropriately) is also possible - see example data.

The only difference between the two SOMA functions is that SOMA_all produces the componet measures (number of common items, number of observed pairs, etc.) while SOMA produces only the triad SOMA.

**SOMA_all** 
```r
resp_A <- c("king", "palace", "forest", "poem") # persona A's recall output
resp_B <- c("walnut", "sorrow", "mountain", "game", "forest", "poem") # person B's recall output
resp_C <- c("forest", "game", "bank", "mountain", "walnut", "sorrow") # person C's recall output

SOMA_all(resp_A, resp_B, resp_C)
```

**SOMA**  
```r
SOMA(resp_A, resp_B, resp_C)
```
As with PF, one important thing to note: 

Blank (NA) values (not shown in example above, but see example data) will *not* count toward a pair. Thus, if you want intrusions to count, simply leave them in the protocol. If you don't want intrusions to count, and want them to break pairs of words, remove the word and leave an empty cell.

## References
**ARC**: Roenker, D. L., Thompson, C. P., & Brown, S. C. (1971). Comparison of measures for the estimation of clustering in free recall. Psychological Bulletin, 76(1), 45–48. https://doi.org/10.1037/h0031355 

**PF**: Sternberg, R. J., & Tulving, E. (1977). The measurement of subjective organization in free recall. Psychological Bulletin, 84, 539-556.

**SOMA**: Congleton. A. R., & Rajaram, S. (2014). Collaboration changes both the content and the structure of memory: Building the architecture of shared representations. Journal of Experimental Psychology: General, 143(4), 1570-1584. https://doi.org/10.1037/a0035974
