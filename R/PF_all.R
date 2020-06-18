# PF_all produces PF and all sub and summary statistics

PF_all <- function(resp_1, resp_2) {

  h = plyr::count(na.omit(resp_1)) # grab trial 1 responses and count
  h = sum(h$freq) # sum them

  k = plyr::count(na.omit(resp_2)) # grab trial 2 responses and count
  k = sum(k$freq) # sum them

  common = length(dplyr::intersect(na.omit(resp_1), na.omit(resp_2))) # common item trial 1 to 2

  Eirt = (2 * common) * (common - 1) / (h * k) # expected pairs trial 1 to trial 2

  ###

  `%>%` <- magrittr::`%>%`

  t_1_o <- data.frame(resp_1) # prep trial 1 responses
  t_1_f <- data.frame(dplyr::lead(resp_1)) # get next words
  t_1_b <- data.frame(dplyr::lag(resp_1)) # get previous words

  t_1_combs <- data.frame(c(t_1_o, t_1_f, t_1_b)) # combine
  colnames(t_1_combs) <- c("original_w", "next_w", "prev_w") # and name

  t_1_combs$original_w <- as.character(t_1_combs$original_w) # make character
  t_1_combs$next_w <- as.character(t_1_combs$next_w)
  t_1_combs$prev_w <- as.character(t_1_combs$prev_w)

  t_1_combs <- t_1_combs %>%
    tidyr::unite("for_pairs", c("original_w","next_w"), remove = FALSE, na.rm = FALSE) %>% # merge original order with next word - forward pairs - (word 1 - word 2) while keeping NAs in pairs
    tidyr::unite("back_pairs", c("original_w", "prev_w"), remove = FALSE, na.rm = FALSE) %>% # merge original order with precious word - backward pairs (word 2 - word 1) while keeping NAs in pairs
    dplyr::select(for_pairs, back_pairs) # keep the pairs

  t_1_combs <- data.frame(t_1_pairs = unlist(t_1_combs)) # make single column of pairs
  t_1_combs$detect_na1 <- stringr::str_detect(t_1_combs$t_1_pairs, "NA_") # find pairs with blanks (NAs)
  t_1_combs$detect_na2 <- stringr::str_detect(t_1_combs$t_1_pairs, "_NA") # find pairs with blanks (NAs)

  t_1_combs <- t_1_combs %>%
    dplyr::filter(detect_na1 == "FALSE" &
                    detect_na2 == "FALSE") %>% dplyr::select(t_1_pairs) # keep only pairs with no blanks (NAs)

  ### SAME CODE REPEATS FOR TRIAL 2

  t_2_o <- data.frame(resp_2)
  t_2_f <- data.frame(dplyr::lead(resp_2))
  t_2_b <- data.frame(dplyr::lag(resp_2))

  t_2_combs <- data.frame(c(t_2_o, t_2_f, t_2_b))
  colnames(t_2_combs) <- c("original_w", "next_w", "prev_w")

  t_2_combs$original_w <- as.character(t_2_combs$original_w)
  t_2_combs$next_w <- as.character(t_2_combs$next_w)
  t_2_combs$prev_w <- as.character(t_2_combs$prev_w)

  t_2_combs <- t_2_combs %>%
    tidyr::unite("for_pairs", c("original_w","next_w"), remove = FALSE, na.rm = FALSE) %>%
    tidyr::unite("back_pairs", c("original_w", "prev_w"), remove = FALSE, na.rm = FALSE) %>%
    dplyr::select(for_pairs, back_pairs)

  t_2_combs <- data.frame(t_2_pairs = unlist(t_2_combs))
  t_2_combs$detect_na1 <- stringr::str_detect(t_2_combs$t_2_pairs, "NA_")
  t_2_combs$detect_na2 <- stringr::str_detect(t_2_combs$t_2_pairs, "_NA")

  t_2_combs <- t_2_combs %>%
    dplyr::filter(detect_na1 == "FALSE" &
                    detect_na2 == "FALSE") %>% dplyr::select(t_2_pairs)

  ###

  Oirt = length(dplyr::intersect(t_1_combs$t_1_pairs, t_2_combs$t_2_pairs)) -
    (.5 * length(dplyr::intersect(t_1_combs$t_1_pairs, t_2_combs$t_2_pairs))) # observed pairs trial 1 to 2 - half the length so pairs are not double counted

  PF = Oirt - Eirt

  out_list <- list(PF = PF, Oirt = Oirt, Eirt = Eirt,
                   Correct_1 = h,
                   Correct_2 = k,
                   Common = common)

  return(out_list) # gives PF sub-measures if of interest, plus PF
  ###

}
