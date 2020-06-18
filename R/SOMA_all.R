# SOMA_all produces all sub and summary statistics

SOMA_all <- function(resp_A, resp_B, resp_C) {

  h = plyr::count(na.omit(resp_A)) # grab subject A correct responses and count
  h = sum(h$freq) # sum them

  k = plyr::count(na.omit(resp_B)) # grab subject B correct responses and count
  k = sum(k$freq) # sum them

  m = plyr::count(na.omit(resp_C)) # grab subject C correct responses and count
  m = sum(m$freq) # sum them


  common_1_2 = length(dplyr::intersect(na.omit(resp_A), na.omit(resp_B))) # common items A and B
  common_1_3 = length(dplyr::intersect(na.omit(resp_A), na.omit(resp_C))) # common items A and C
  common_2_3 = length(dplyr::intersect(na.omit(resp_B), na.omit(resp_C))) # common items B and C

  Eirt_1_2 = (2 * common_1_2) * (common_1_2 - 1) / (h * k) # expected pairs A and B
  Eirt_1_3 = (2 * common_1_3) * (common_1_3 - 1) / (h * m) # expected pairs A and C
  Eirt_2_3 = (2 * common_2_3) * (common_2_3 - 1) / (k * m) # expected pairs B and C

  ###

  `%>%` <- magrittr::`%>%`

  t_1_o <- data.frame(resp_A) # prep all subject A responses
  t_1_f <- data.frame(dplyr::lead(resp_A)) # get next words
  t_1_b <- data.frame(dplyr::lag(resp_A)) # get previous words

  t_1_combs <- data.frame(c(t_1_o, t_1_f, t_1_b)) # combine
  colnames(t_1_combs) <- c("original_w", "next_w", "prev_w") # and name

  t_1_combs$original_w <- as.character(t_1_combs$original_w) # make character
  t_1_combs$next_w <- as.character(t_1_combs$next_w)
  t_1_combs$prev_w <- as.character(t_1_combs$prev_w)

  t_1_combs <- t_1_combs %>%
    tidyr::unite("for_pairs", c("original_w","next_w"), remove = FALSE, na.rm = FALSE) %>% # merge original order with next word - forward pairs - (word 1 - word 2) while keeping NAs in pairs
    tidyr::unite("back_pairs", c("original_w", "prev_w"), remove = FALSE, na.rm = FALSE) %>% # merge original order with precious word - backward pairs (word 2 - word 1) while keeping NAs in pairs
    dplyr::select(for_pairs, back_pairs) # keep the pairs

  t_1_combs <- data.frame(t_1_pairs = unlist(t_1_combs)) # make single column with all pairs
  t_1_combs$detect_na1 <- stringr::str_detect(t_1_combs$t_1_pairs, "NA_") # find pairs with blanks (NAs)
  t_1_combs$detect_na2 <- stringr::str_detect(t_1_combs$t_1_pairs, "_NA") # find pairs with blanks (NAs)

  t_1_combs <- t_1_combs %>%
    dplyr::filter(detect_na1 == "FALSE" &
                    detect_na2 == "FALSE") %>% dplyr::select(t_1_pairs) # keep only pairs with no blanks (NAs)

  ### SAME CODE REPEATS FOR SUBJECTS B AND C ---

  t_2_o <- data.frame(resp_B)
  t_2_f <- data.frame(dplyr::lead(resp_B))
  t_2_b <- data.frame(dplyr::lag(resp_B))

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

  t_3_o <- data.frame(resp_C)
  t_3_f <- data.frame(dplyr::lead(resp_C))
  t_3_b <- data.frame(dplyr::lag(resp_C))

  t_3_combs <- data.frame(c(t_3_o, t_3_f, t_3_b))
  colnames(t_3_combs) <- c("original_w", "next_w", "prev_w")

  t_3_combs$original_w <- as.character(t_3_combs$original_w)
  t_3_combs$next_w <- as.character(t_3_combs$next_w)
  t_3_combs$prev_w <- as.character(t_3_combs$prev_w)

  t_3_combs <- t_3_combs %>%
    tidyr::unite("for_pairs", c("original_w","next_w"), remove = FALSE, na.rm = FALSE) %>%
    tidyr::unite("back_pairs", c("original_w", "prev_w"), remove = FALSE, na.rm = FALSE) %>%
    dplyr::select(for_pairs, back_pairs)

  t_3_combs <- data.frame(t_3_pairs = unlist(t_3_combs))
  t_3_combs$detect_na1 <- stringr::str_detect(t_3_combs$t_3_pairs, "NA_")
  t_3_combs$detect_na2 <- stringr::str_detect(t_3_combs$t_3_pairs, "_NA")

  t_3_combs <- t_3_combs %>%
    dplyr::filter(detect_na1 == "FALSE" &
                    detect_na2 == "FALSE") %>% dplyr::select(t_3_pairs)

  ###

  Oirt_1_2 = length(dplyr::intersect(t_1_combs$t_1_pairs, t_2_combs$t_2_pairs)) -
    (.5 * length(dplyr::intersect(t_1_combs$t_1_pairs, t_2_combs$t_2_pairs))) # observed pairs A to B - half the length so pairs are not double counted

  Oirt_1_3 = length(dplyr::intersect(t_1_combs$t_1_pairs, t_3_combs$t_3_pairs)) -
    (.5 * length(dplyr::intersect(t_1_combs$t_1_pairs, t_3_combs$t_3_pairs))) # observed pairs A to C - half the length so pairs are not double counted

  Oirt_2_3 = length(dplyr::intersect(t_2_combs$t_2_pairs, t_3_combs$t_3_pairs)) -
    (.5 * length(dplyr::intersect(t_2_combs$t_2_pairs, t_3_combs$t_3_pairs))) # observed pairs B to C - half the length so pairs are not double counted

  ###

  SOMA_1_2 = Oirt_1_2 - Eirt_1_2 # get soma A to B
  SOMA_1_3 = Oirt_1_3 - Eirt_1_3 # get soma A to C
  SOMA_2_3 = Oirt_2_3 - Eirt_2_3 # get soma B to C

  SOMA_triad = (SOMA_1_2 + SOMA_1_3 + SOMA_2_3) / 3 # average for triad soma

  out_list <- list(SOMA_Triad = SOMA_triad,
                   SOMA_1_2 = SOMA_1_2,
                   SOMA_1_3 = SOMA_1_3,
                   SOMA_2_3 = SOMA_2_3,
                   Correct_1 = h, Correct_2 = k, Correct_3 = m,
                   Common_1_2 = common_1_2,
                   Oirt_1_2 = Oirt_1_2,
                   Eirt_1_2 = Eirt_1_2,
                   Common_1_3 = common_1_3,
                   Oirt_1_3 = Oirt_1_3,
                   Eirt_1_3 = Eirt_1_3,
                   Common_2_3 = common_2_3,
                   Oirt_2_3 = Oirt_2_3,
                   Eirt_2_3 = Eirt_2_3)
  return(out_list) # gives a bunch of sub-measures in addition to SOMA
  ###

}

