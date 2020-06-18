# SOMA produces only SOMA value (relies on PF_all)

SOMA <- function(resp_A, resp_B, resp_C) {

  SOMA_1_2 <- PF_all(resp_A, resp_B) # PF_all function applied to A and B
  SOMA_1_2 = SOMA_1_2$PF # soma is just PF between people

  SOMA_1_3 <- PF_all(resp_A, resp_C) # PF_all function applied to A and C
  SOMA_1_3 = SOMA_1_3$PF # soma is just PF between people

  SOMA_2_3 <- PF_all(resp_B, resp_C) # PF_all function applied to B and C
  SOMA_2_3 = SOMA_2_3$PF # soma is just PF between people

  SOMA_triad = (SOMA_1_2 + SOMA_1_3 + SOMA_2_3) / 3 # average for triad

  out_list <- list(SOMA_triad = SOMA_triad)

  return(out_list) # gives only triad SOMA (if that's all you need)

}

