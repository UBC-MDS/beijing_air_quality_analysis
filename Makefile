# pipe
# authors: 
# date:date

all: results/violin_plot.png results/time_A_B_distribution.png results/combined_distribution_plot_1.png results/pvalue.csv src/Beijing_air_quality_EDA.md doc/Beijing_air_quality_report.md

#download data
data/raw/PRSA2017_Data_20130301-20170228: src/download_data.py data/raw/PRSA2017_Data_20130301-20170228/*.csv
    python src/download_data.py --url=https://archive.ics.uci.edu/ml/machine-learning-databases/00501/PRSA2017_Data_20130301-20170228.zip --out_folder=data/raw

#pre-process data
data/processed/processed_data.csv: data/raw/PRSA2017_Data_20130301-20170228
    Rscript src/pre_process_data.R --input=data/raw/PRSA_Data_20130301-20170228 --out_dir=data/processed

#create exploratory data analysis figure and write to file
#results/time_A_B_distribution.png results/combined_distribution_plot_1.png: src/Beijing_air_quality_EDA.md src/Beijing_air_quality_EDA.Rmd data/processed/processed_data.csv
#    Rscript src/eda_generate_plots.R --input=data/processed/processed_data.csv --out_dir=results

# hypothesis_testing
results/violin_plot.png results/pvalue.csv: data/processed/processed_data.csv
    Rscript src/hypothesis_testing_script.R --input=data/processed/processed_data.csv --out_dir=results

# render final report
doc/Beijing_air_quality_report.html index.html: doc/*.Rmd
    Rscript -e "rmarkdown::render('doc/Beijing_air_quality_report.Rmd', output_format = 'html_document')"

clean:
		rm -rf results
		rm -rf data
		rm -rf doc/Beijing_air_quality_report.html
		rm -rf src/Beijing_air_quality_EDA.html
		rm -rf src/Beijing_air_quality_EDA.md
		rm -rf src/Beijing_air_quality_EDA_files