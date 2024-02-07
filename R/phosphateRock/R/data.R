NULL

#' Phosphate mining and beneficiation complexes: general information
#' 
#' General properties of individual phosphate mining and beneficiation complexes, 
#' including their name, geographical location, type of rock, ownership, 
#' production capacity, and operational status. 
#' 
#' @docType data
#'
#' @format A data frame with 8 columns:
#' \describe{
#' \item{Name}{Name of the complex}
#' \item{Region}{Region name (according to the IFA classification)}
#' \item{Country}{Country name (according to the U.S. Geological Survey)}
#' \item{Subnational_area}{Sub-national administrative area (e.g., region, state, province)}
#' \item{Company}{Name of the company owning mining and beneficiation facilities}
#' \item{Rock_type}{Type of rock formation: \emph{sedimentary} or \emph{igneous}}
#' \item{Status}{Status of mining project: \emph{operational} or \emph{in development}}
#' \item{Capacity}{Capacity in million tonnes of mass of phosphate rock (PR)}
#' }
#' 
"mining_complexes"


#' Phosphate ore: grades
#' 
#' Manually collected complex-specific data on the average grades of phosphate ore used for beneficiation.
#' The grade refers to the concentration of P2O5 ore contains.
#' All data points are provided on the annual basis and linked to their respective source document(s).
#' 
#' Ore is considered as run of mine (ROM) - ore from mining prior to beneficiation.
#' 
#' @docType data
#'
#' @format A data frame with 4 columns:
#' \describe{
#' \item{Name}{Name of the phosphate mining and beneficiation complex}
#' \item{Confidence}{\emph{High} (relevant company's data), \emph{Medium} or \emph{Low}}
#' \item{Value}{Grade, \% P2O5}
#' \item{Source}{Identifier for document(s) used as data source(s) (see \code{\link{sources}} for details)}
#' } 
#'
"ore"


#' Phosphate rock (PR): grades
#' 
#' Manually collected complex-specific data on the average grades of PR produced.
#' The grade refers to the concentration of P2O5 PR contains.
#' All data points are provided on the annual basis and linked to their respective source document(s). 
#' 
#' PR is considered as run of beneficiation plant - ore after beneficiation averaged over processing streams.
#' 
#' @docType data
#'
#' @format A data frame with 4 columns:
#' \describe{
#' \item{Name}{Name of the phosphate mining and beneficiation complex}
#' \item{Confidence}{\emph{High} (relevant company's data), \emph{Medium} or \emph{Low}}
#' \item{Value}{Grade, \% P2O5}
#' \item{Source}{Identifier for document(s) used as data source(s) (see \code{\link{sources}} for details)}
#' }
#' 
"PR"


#' Mineral: grades
#' 
#' Manually collected complex-specific data on the average grades of 
#' representative phosphate-bearing mineral associated with ore deposit.
#' The grade refers to the concentration of P2O5 mineral contains.
#' All data points are provided on the annual basis and linked to their respective source document(s). 
#' 
#' Minerals containing phosphates in their chemical composition are classified as phosphate minerals.
#' About 200 of them are known to contain 1\% or more P2O5. 95\% of P in
#' the Earth's crust is bound in the various forms of apatites (Krauss et al. 1984); a number of other
#' iron- and aluminum-rich phosphate minerals, such as crandallite, millisite, wavellite and strengite, can
#' occur in the supergene enriched zones above a primary phosphate deposit (Pufahl and Groat 2016).
#' In igneous deposits, apatites approaching composition of pure fluorapatite are most common (McClellan and van Kauwenbergh 1990).
#' Most of them contain the carbonate fluorapatite variety assigned to francolite (McClellan and van Kauwenbergh 1990) - carbonate
#' fluorapatites containing more than 1\% fluorine and appreciable amounts of CO2.
#' See \code{\link{sources}} for classification of representative complex-specific phosphate-bearing minerals used in this dataset.
#' 
#' @docType data
#'
#' @format A data frame with 4 columns:
#' \describe{
#' \item{Name}{Name of the phosphate mining and beneficiation complex}
#' \item{Confidence}{\emph{Standard} for raw data, or \emph{Low} for data from similar deposit and/or averaged}
#' \item{Value}{Grade, \% P2O5}
#' \item{Source}{Identifier for document(s) used as data source(s) (see \code{\link{sources}} for details)}
#' }
#' 
#' @references 
#' \itemize{
#'   \item Krauss, U., Saam, H., & Schmidt, H. (1984). International strategic minerals inventory. Summary report - Phosphate. USGS Circular 930-C.
#'   \item McClellan, G. H. (1980). Mineralogy of carbonate fluorapatites. Journal of the Geological Society, 137: 675-681. https://doi.org/10.1144/gsjgs.137.6.0675
#' 	 \item McClellan, G. H., & van Kauwenbergh, S. J. (1990). Mineralogy of sedimentary apatites. Journal of the Geological Society, 137(6): 675-681. https://doi.org/10.1144/gsjgs.137.6.0675
#'   \item Pufahl, P. K., & Groat, L. A. (2016). Sedimentary and igneous phosphate deposits: formation and exploration: an invited paper. Economic Geology, 112(3): 483-516. https://doi.org/10.2113/econgeo.112.3.483
#' }
#' 
"mineral"


#' Beneficiation: mass recoveries
#' 
#' Manually collected complex-specific data on the average mass recovery rates.
#' The mass recovery refers to the ratio of the mass of produced PR to the mass of ore prior beneficiation.
#' All data points are provided on the annual basis and linked to their respective source document(s).
#' 
#' A data source contains information whether primary data was used or value was
#' estimated from \code{\link{recovery_mineral}}.
#' 
#' @docType data
#'
#' @format A data frame with 5 columns:
#' \describe{
#' \item{Name}{Name of the phosphate mining and beneficiation complex}
#' \item{Confidence}{\emph{High} (relevant company's data), \emph{Medium} or \emph{Low}}
#' \item{Value}{PR-to-ore ratio}
#' \item{Source}{Identifier for document(s) used as data source(s) (see \code{\link{sources}} for details)}
#' }
#' 
"recovery_mass"


#' Beneficiation: mineral recoveries
#' 
#' Manually collected complex-specific data on the average mineral recovery rates.
#' The mineral recovery refers to the percent of P2O5 recovered in the PR from the ore after beneficiation.
#' All data points are provided on the annual basis and linked to their respective source document(s).
#' 
#' A data source contains information whether primary data was used or value was
#' estimated from \code{\link{recovery_mass}}.
#' 
#' @docType data
#'
#' @format A data frame with 5 columns:
#' \describe{
#' \item{Name}{Name of the phosphate mining and beneficiation complex}
#' \item{Confidence}{\emph{High} (relevant company's data), \emph{Medium} or \emph{Low}}
#' \item{Value}{Ratio of \% P2O5 in PR to \% P2O5 in ore}
#' \item{Source}{Identifier for document(s) used as data source(s) (see \code{\link{sources}} for details)}
#' }
#' 
"recovery_mineral"


#' List of data sources 
#' 
#' General information about data sources, including their identifiers, references to source document(s),
#' data relevance, and notes on data collection.
#' 
#' For bibliography, see 
#' \href{../doc/References.pdf}{phosphateRock::References}
#' 
#' @docType data
#'
#' @format A data frame with 4 columns:
#' \describe{
#' \item{Source}{Identifier for citation}
#' \item{Reference}{Brief bibliographical reference(s) to source document(s)}
#' \item{Year}{Year of relevance}
#' \item{Note_confidence}{Notes on quality of source data}
#' \item{Comment}{Additional notes on data collection}
#' }
#' 
"sources"


