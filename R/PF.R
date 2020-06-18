# PF simply produces PF value (requires PF all to be active/loaded)

PF <- function(resp_1, resp_2) {

  PF <- PF_all(resp_1, resp_2) # apply PF_all function to responses
  PF = PF$PF

  out_list <- list(PF = PF)

  return(out_list) # gives only PF (if that's all you need)
  ###

}

