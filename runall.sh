# Macy Chan
# 2021-11-25
#
# Driver script/snalysis pipeline for rendering Beijing Air Quality reports
#
# Usage:
# bash runall.sh

# Remove output file if exisit
rm -rf data
echo "Related project output have been removed, start rendering.."

# download and unzip data
python src/download_data.py --url=https://archive.ics.uci.edu/ml/machine-learning-databases/00501/PRSA2017_Data_20130301-20170228.zip --out_folder=data/raw
echo "Complete downloading raw data..."

# pre-process data 
Rscript src/pre_process_data.R --data=data/raw/PRSA_Data_20130301-20170228 --out_dir=data/processed

# create exploratory data analysis figure and write to file 
Rscript src/eda_generate_plots.R --data=data/processed/PRSA_Data_processed.csv --out_dir=results

# run eda report
Rscript -e "rmarkdown::render('src/Beijing_air_quality_EDA.Rmd')"
echo "Complete rendering EDA report.."

# create hypothesis testing data/figures and write to file 
Rscript src/hypothesis_testing_script.R --data=data/processed/PRSA_Data_processed.csv --out_dir=results

# render final report
Rscript -e "rmarkdown::render('doc/Beijing_air_quality_report.Rmd', output_format = 'github_document')"
echo "Complete rendering final report"