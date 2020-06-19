\name{PF}
\alias{PF}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Paired Frequency (PF)
%%  ~~function to do ... ~~
}
\description{Adapted from Sternberg & Tulving (1977). Computes PF for items between recall trial and trial + 1.
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
PF(resp_1, resp_2)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{resp_1}{Character vector containing items (word responses) produced at trial 1}
  \item{resp_2}{Character vector containing items (word responses) produced at trial 2}
%%     ~~Describe \code{x} here~~
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{Sternberg, R. J., & Tulving, E. (1977). The measurement of subjective organization in free recall. Psychological Bulletin, 84, 539-556.
%% ~put references to the literature/web site here ~
}
\author{
Garrett. D Greeley

Ph.D. Student - Cognitive Science

Stony Brook University, NY
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
PF_all()

SOMA()

SOMA_all()
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
recall_1 <- c("king", "palace", "forest", "poem")
recall_2 <- c("walnut", "sorrow", "mountain", "game", "forest", "poem")

PF(recall_1, recall_2)

Or with example data PF_test and PF_test_intrusion (adapted from Sternberg & Tulving, 1977):

PF(PF_test$R_1_word, PF_test$R_2_word)
PF(PF_test_intrusion$R_1_word, PF_test_intrusion$R_2_word)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~clustering }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~psychometrics }% __ONLY ONE__ keyword per line
\keyword{ ~psychology }
\keyword{ ~memory }
\keyword{ ~organization }
