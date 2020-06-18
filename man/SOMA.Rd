\name{SOMA}
\alias{SOMA}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Shared Organization Metric Analysis (SOMA)
%%  ~~function to do ... ~~
}
\description{Adapted from Congelton & Rajaram (2014). Computes SOMA for a triad (three individuals). Computationally equivalent to PF but assesses pairs across multiple individuals instead of within the same individual's multiple recall phases.
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
SOMA(resp_A, resp_B, resp_C)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{resp_A}{Character vector containing items (word responses) produced by Person A}
  \item{resp_B}{Character vector containing items (word responses) produced by Person B}
  \item{resp_C}{Character vector containing items (word responses) produced by Person C}
%%     ~~Describe \code{x} here~~
}
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
\references{Congleton. A. R., & Rajaram, S. (2014). Collaboration changes both the content and the structure of memory: Building the architecture of shared representations. Journal of Experimental Psychology: General, 143(4), 1570-1584. https://doi.org/10.1037/a0035974

Sternberg, R. J., & Tulving, E. (1977). The measurement of subjective organization in free recall. Psychological Bulletin, 84, 539-556.
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
PF()

PF_all()

SOMA_all()
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
resp_A <- c("king", "palace", "forest", "poem")
resp_B <- c("walnut", "sorrow", "mountain", "game", "forest", "poem")
resp_C <- c("forest", "game", "bank", "mountain", "walnut", "sorrow")

SOMA(resp_A, resp_B, resp_C)

Or with example data SOMA_test and SOMA_test_intrusion (adapted from Sternberg & Tulving, 1977):

SOMA(SOMA_test$A_response, SOMA_test$B_response, SOMA_test$C_response)
SOMA(SOMA_test_intrusion$A_response, SOMA_test_intrusion$B_response, SOMA_test_intrusion$C_response)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~clustering }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~psychometrics }% __ONLY ONE__ keyword per line
\keyword{ ~psychology }
\keyword{ ~memory }
\keyword{ ~organization }
