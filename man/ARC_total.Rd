\name{ARC_total}
\alias{ARC_total}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Adjusted Ratio of Clustering (ARC) - Total Recall
%%  ~~function to do ... ~~
}
\description{Adapted from Roenker, Thompson, & Brown (1971). Computes ARC using the total, uncorrected recall (N) of an individual or group. Also produces several other out-dated measures of category clustering and the componets of ARC (E(r), N, Repetitions, and Max).

Use when:

You want all items, correct (1) or not (0), counted toward N - AND

There are NO intrusions present in data - OR

You have intrusions coded (i.e. INTRUSION category - not left blank) and want them to count as a category in E(r) calculation.


See "details" for more on the formula, notation definitions, and further explanation.

%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
ARC_total(correct, category)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{correct}{Numeric vector representing correct (1) and incorrect (0) responses.}
  \item{category}{Numeric or character vector representing category membership of associated item in x column.}
%%     ~~Describe \code{x} here~~
}
\details{
ARC = [r − E(r)] / [max − E(r)]

E(r) = [ (∑ni^2) / N ] − 1

r = number of category repetitions

N = number of recalled items (correct and incorrect)

c = number of recalled categories (including intrusions)

max = N − c   and

ni = number of items recalled in each recalled category (including intrusions)

General - This will count category repetitions (but NOT repeated blank (NA) entries) and the total N (including blanks) is used in all computations (max and E(r)). Be sure data is properly processed (according to your protocol) before using.

%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{Roenker, D. L., Thompson, C. P., & Brown, S. C. (1971). Comparison of measures for the estimation of clustering in free recall. Psychological Bulletin, 76(1), 45–48. https://doi.org/10.1037/h0031355
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
ARC_total_intrude()

ARC_correct()

ARC_correct_intrude()
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
Data adapted from Roenker et al. (1971) - Also see ARC_3SE and other example data in the package for more examples and formatting.

recall_correct <- c(1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1)
recall_category <- c("a","a", NA ,"a","a","b","a","c","b","b","b","b","c","b","c","c","c","c")


ARC_total(recall_correct, recall_category)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~clustering }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~psychometrics }% __ONLY ONE__ keyword per line
\keyword{ ~psychology }
\keyword{ ~memory }
\keyword{ ~organization }
