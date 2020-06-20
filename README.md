# MemoryOrg
A Minimal R Package Dedicated to Quantifying Retrieval Organization

## What the Package Does and Why

This package contains functions that compute **Adjusted Ratio of Clustering** (ARC), **Paired Frequency** (PF), and the **Shared Organization Metric Analysis** (SOMA). In human memory research, these are all measures of retireval organization in free-recall contexts. That is, beyond quantity ("75% of items were recalled"), these organizational metrics assess the *structure* of memory - or *how* items are recalled. 

**ARC**: Roenker et al. (1971) developed ARC as a measure of *category clustering*. That is, ARC assess the tendency for individuals to group or cluster studied items by category at recall. For example, a participant could study a 60-item list consisting of 6 categories, with 10 exemplars per category. At recall, ARC evaluates the repetitions of categories present in the output (how frequently an item of a category follows an item of the same category). As a ratio, ARC scores approaching 1 are highly organized (clustered by category) while scores closer to 0 indicate chance clustering.

**PF**: Sternberg & Tulving (1977) developed PF as a measure of *subjective* organization. Unlike ARC (which requires study lists to have some inherent structure, such as categories), PF assesses the number of forward and backward pairs of items across recall trials. For example, a participant could study a list of unrelated nouns and perform two or more free-recall tests. PF would assess the pairs present in each recall, as well as the expected number of pairs. Higher PF indicates more consistent organization between the recalls in question (recall 1 - 2, recall 2 - 3, etc.).

**SOMA**: Congleton & Rajaram (2014) adapted Sternberg and Tulving's (1977) measure of PF to quantify the retrieval organization *shared* by multiple individuals. SOMA accomplishes this by applying the same computation to the recall outputs of two *different* individuals. For groups larger than two, SOMA is simply the average of all possible two-person SOMA comparisons. Just like PF, higher SOMA indicates greater shared organization among the group in question.

While each of these measures approach retrieval organization differently, the utility of each comes from their ability to shed light on the structure of memory in free-recall. Finally, this is obviously just a brief introduction to these measures. For a deeper look, check out the references below!

# Getting Started

MemoryOrg is hosted on Github, so you can use devtools to install the package. If you don't have devtools already, you'll need to install it. With that installed, install_github should work nicely.
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

# with example data (Roenker et al., 1971)
ARC_correct(ARC_3LE$recall_correct, ARC_3LE$recall_category_name)
```

**ARC_total**  
```r
ARC_total(recall_correct, recall_category)

# with example data (Roenker et al., 1971)
ARC_total(ARC_3SE_intrusion$recall_correct,
          ARC_3SE_intrusion$recall_category_name)
```

**ARC_correct_intrude**  
```r
ARC_correct_intrude(recall_correct, recall_category)

# with example data (Roenker et al., 1971)
ARC_correct_intrude(ARC_3SE_intrusion$recall_correct,
                    ARC_3SE_intrusion$recall_category_name)
```

**ARC_total_intrude**  
```r
ARC_total_intrude(recall_correct, recall_category)

# with example data (Roenker et al., 1971)
ARC_total_intrude(ARC_3SE_intrusion$recall_correct,
                  ARC_3SE_intrusion$recall_category_name)
```

A few important things to note: 

All ARC functions produce a list that can be stored as an object. Specific measures (ARC, correct/total, and other metrics) can then be referenced individually.

Back-to-back NA's *do not* count toward repetitions (even if NA's are being counted as a category as they are in ARC_total and ARC_correct). Thus, if you want to measure clustering of intrusions, code them rather than leaving them blank. 

Additionally, "correct" and "total" in the functions refer to the vector indicating correct/incorrect responses. This will impact the N in Max and E(r) calculations (see documentation and note the different results with the same data). 

Finally, functions containing "intrude" don't count blank NA values as a category, though ARC_total_intrude will still count them toward N. Both "intrude" functions, then, do not count NA values toward the E(r) numerator.

Moral of the story: in most real applications (intrusions present, interest in clustering of correct words) - ARC_correct_intrude is likely the best bet.

# PF 
Each PF function takes two arguments: a vector of words (recall output) and... another vector of words (another recall output). PF assess the number of forward and backward pairs of items from recall trial X to recall trial X+1. Really, any two outputs can be compared, but that is the classic approach. Just as with ARC, reading-in a CSV or similar file with the output of a participant (cleaned appropriately) is also possible - see example data.

The only difference between the two PF functions is that PF_all produces PF *and* the componet measures (number of common items, number of observed pairs, etc.) while PF produces only PF.

**PF_all**  
```r
recall_1 <- c("king", "palace", "forest", "poem") # recall output (e.x., recall 1)
recall_2 <- c("walnut", "sorrow", "mountain", "game", "forest", "poem") # another recall output (e.x., recall 2)

PF_all(recall_1, recall_2)

# with example data (Sternberg & Tulving, 1977)
PF_all(PF_test$R_1_word, PF_test$R_2_word)
```

**PF**
```r
PF(recall_1, recall_2)

# with example data (Sternberg & Tulving, 1977)
PF(PF_test$R_1_word, PF_test$R_2_word)
```

Two important things to note: 

Like ARC, both PF functions produce a list that can be stored as an object and referenced later.

Blank (NA) values (not shown in example above, but see example data) will *not* count toward a pair. Thus, if you want intrusions to count, simply leave them in the protocol. If you don't want intrusions to count, and want them to break pairs of words, remove the word and leave an empty cell.

# SOMA
Both SOMA functions take three arguments: a vector of words (recall output), another vector of words (another recall output), and...another vector of words (another recall output). Computationally equivalent to PF, but with a key difference in motivation, SOMA assesses the number of forward and backward pairs of items **across multiple individuals**. That is, it is a measure of shared organization.  Specifically, these functions handle triads (i.e., responses of three individuals). SOMA_all produces dyad level SOMA and measurements, but if just two individuals are being compared, you should just use PF_all or PF. Just as with ARC and PF, reading-in a CSV or similar file with the output of a participant (cleaned appropriately) is also possible - see example data.

The only difference between the two SOMA functions is that SOMA_all produces the triad SOMA *and* the componet measures (number of common items, number of observed pairs, etc.) while SOMA produces only the triad SOMA.

**SOMA_all** 
```r
resp_A <- c("king", "palace", "forest", "poem") # persona A's recall output
resp_B <- c("walnut", "sorrow", "mountain", "game", "forest", "poem") # person B's recall output
resp_C <- c("forest", "game", "bank", "mountain", "walnut", "sorrow") # person C's recall output

SOMA_all(resp_A, resp_B, resp_C)

# with example data (adapted from Sternberg & Tulving, 1977)
SOMA_all(SOMA_test$A_response, SOMA_test$B_response, SOMA_test$C_response)
```

**SOMA**  
```r
SOMA(resp_A, resp_B, resp_C)

# with example data (adapted from Sternberg & Tulving, 1977)
SOMA(SOMA_test$A_response, SOMA_test$B_response, SOMA_test$C_response)
```
As with PF, two important things to note: 

Like ARC and PF, SOMA functions produce a list that can be stored as a object and reference later.

Finally, blank (NA) values (not shown in example above, but see example data) will *not* count toward a pair. Thus, if you want intrusions to count, simply leave them in the protocol. If you don't want intrusions to count, and want them to break pairs of words, remove the word and leave an empty cell.

## References
**ARC**: Roenker, D. L., Thompson, C. P., & Brown, S. C. (1971). Comparison of measures for the estimation of clustering in free recall. Psychological Bulletin, 76(1), 45–48. https://doi.org/10.1037/h0031355 

**PF**: Sternberg, R. J., & Tulving, E. (1977). The measurement of subjective organization in free recall. Psychological Bulletin, 84, 539-556.

**SOMA**: Congleton. A. R., & Rajaram, S. (2014). Collaboration changes both the content and the structure of memory: Building the architecture of shared representations. Journal of Experimental Psychology: General, 143(4), 1570-1584. https://doi.org/10.1037/a0035974
