# Sum Things
## Overview
This repo contains the data and R code used for the study presented in the following paper:

[*Carleton and Groucutt "Sum things are not what they seem: Problems with the interpretation and analysis of radiocarbon-date proxies".*](https://osf.io/preprints/socarxiv/yp38j/)

## Abstract
Radiocarbon-date proxies are widely used in studies exploring long-term variation in  human and environmental phenomena. Examined phenomena include, for example, variation in past human population levels and climate-change-driven sea level fluctuations. These processes are thought to have affected the amount of organic carbon deposited into the archaeological and/or palaeoenvironmental record at a given time. Time-series representing through-time fluctuations in the frequency of dated radiocarbon samples are, therefore, often used as proxies for such processes. However, there are important problems with radiocarbon-date proxies that have so far gone underappreciated in the scientific literature. The primary problem is that the proxies are easily misinterpreted, and this has serious implications for downstream analyses. Here we report the results of a two-part study. In the first part, we investigated the most accurate interpretation of radiocarbon-date proxies produced with each of the two established methods, widely-used summed probability density functions and a new kernel density estimation approach. In the second part, we performed a simulated regression experiment to determine whether the proxies could be used to quantitatively investigate the processes they are often thought to represent. Our analyses unfortunately reveal that the proxies do not reflect what they are generally thought to---i.e., through-time variation in processes correlated with radiocarbon sample frequency. Rather, they represent a combination of through-time variation in sample frequency and chronological uncertainty. More importantly, though, our regression experiment demonstrated that the proxies can produce very misleading results. While the proxies may be useful under certain conditions for addressing certain kinds of research questions, they are not generally suitable as representations of through-time processes. A major implication of this finding is that a significant number of high-profile published studies may be reporting false results based on misinterpretations of core data. Another major implication is that the proxies should be avoided in future research when the goal is to understand through-time variation in a given process.

## Software
The R scripts contained in this repository are intended for replication efforts and to improve the transparency of our research. They are, of course, provided without warranty or technical support. That said, questions about the code can be directed to Chris Carleton at ccarleton@protonmail.com.

### OxCal
Much of the data for our anlaysis was produced by [OxCal](https://c14.arch.ox.ac.uk/oxcalhelp/hlp_contents.html), the radiocarbon-date calibration and Bayesian modelling application produced and maintained by [Prof. Christopher Ramsey](https://www.merton.ox.ac.uk/people/professor-christopher-ramsey) at the University of Oxford. The files needed to reproduce OxCal's results (the data we used) are provided in the [OxCal](https://github.com/wccarleton/sumthings/OxCal/) Folder. They are simple text files with the extenstion '.oxcal' and they contained code written in a special *Chronological Query Language (CQL2)* developed specifically for OxCal. To use this code, see OxCal's user manual.

### R
This analysis described in the associated manuscript was performed in R. Thus, you may need to download the latest version of [R](https://www.r-project.org/) in order to make use of the scripts described below.

### Nimble
This project made use of a Bayesian Analysis package called [Nimble](https://r-nimble.org/). See the Nimble website for documentation and a tutorial. Then, refer to the R scripts in this repo that have names beginning with `nimble...`


## Replication Outline
1. Generate simulated data
   * See `./R_scripts/Analysis/simulate_dates_regression.R`
2. Convert the count series into a set of calendar dates and feed it into OxCal using CQL2 (e.g., see `./OxCal/kde_reg_500.oxcal`)
3. Extract OxCal output:
   *  OxCal's output is provided by the application in the form of a JavaScript array written to a text file with a `.js` extension. To make use of this output, the files were parsed with REGEX in R. See `./R_scripts/Analysis/oxcal_parse_regression.R` for an example of this. You may have to adjust file paths to suite your local configuration and file locations.
4. Collate the simulated data and OxCal model output into data frames and run the Nimble code provided in `./R_scripts/Analysis/nimble_...R` scripts. The scripts in the `./R_scripts/Plotting/` folder can be used to produce images like the ones presented in the associated manuscript---you will likely need edit paths and variable names as appropriate in order to make the scripts work, of course.
