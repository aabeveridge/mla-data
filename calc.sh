#!/bin/bash

#Analyze text and create visuals for 2012 job description data
cd ~/mla_data/data/2012
Rscript ~/mla_data/R_scripts/freq-cor_calc.r
Rscript ~/mla_data/R_scripts/visualize.r

#Analyze text and create visuals for 2013 job description data
cd ~/mla_data/data/2013
Rscript ~/mla_data/R_scripts/freq-cor_calc.r
Rscript ~/mla_data/R_scripts/visualize.r

#Analyze text and create visuals for 2014 job description data
cd ~/mla_data/data/2014
Rscript ~/mla_data/R_scripts/freq-cor_calc.r
Rscript ~/mla_data/R_scripts/visualize.r
