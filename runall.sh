# Macy Chan
# 2021-11-25
#
# Driver script/snalysis pipeline for rendering Beijing Air Quality reports
#
# Usage:
# bash runall.sh


# run eda report
run_eda_report () {
        Rscript -e "rmarkdown::render('src/Beijing_air_quality_EDA.Rmd')"
        FILE=src/Beijing_air_quality_EDA.md
        if [ -e "$FILE" ]; then
            echo "Complete rendering EDA report."
        else
            echo "Failed rendering EDA report."
        fi
}


run_fincal_report () {
        # pre-process data 
        Rscript src/pre_process_data.R --input=data/raw/PRSA_Data_20130301-20170228 --out_dir=data/processed
        
        # create exploratory data analysis figure and write to file 
        Rscript src/eda_generate_plots.R --input=data/processed/processed_data.csv --out_dir=results
        
        # create hypothesis testing data/figures and write to file 
        Rscript src/hypothesis_testing_script.R --input=data/processed/processed_data.csv --out_dir=results
        
        # render final report
        Rscript -e "rmarkdown::render('doc/Beijing_air_quality_report.Rmd', output_format = 'html_document')"
        FILE=doc/Beijing_air_quality_report.html
        if [ -e "$FILE" ]; then
            echo "Complete rendering final report"
        else
            echo "Failed rendering final report."
        fi
}


#Start of script
echo "Start rendering process.."

# download and unzip data
python src/download_data.py --url=https://archive.ics.uci.edu/ml/machine-learning-databases/00501/PRSA2017_Data_20130301-20170228.zip --out_folder=data/raw
FILE=data/raw/PRSA_Data_20130301-20170228/PRSA_Data_Aotizhongxin_20130301-20170228.csv
if [ -e "$FILE" ]; then
    echo "Complete downloading raw data...";
    run_eda_report;
    run_fincal_report;
else
    echo "Downloading raw data Failed."
fi