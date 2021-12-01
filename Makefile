# author: Macy Chan
# date: 2021-11-19

all: src/Beijing_air_quality_EDA.md doc/Beijing_air_quality_report.html

# download data
data: src/download_data.py
	python src/download_data.py --url=https://archive.ics.uci.edu/ml/machine-learning-databases/00501/PRSA2017_Data_20130301-20170228.zip --out_folder=data/raw

# pre-process data
data/processed/processed_data.csv: src/pre_process_data.R data
	Rscript src/pre_process_data.R --input=data/raw/PRSA_Data_20130301-20170228 --out_dir=data/processed
	
# run eda report
src/Beijing_air_quality_EDA.md: src/Beijing_air_quality_EDA.Rmd data/processed/processed_data.csv src/references.bib
	Rscript -e "rmarkdown::render('src/Beijing_air_quality_EDA.Rmd', output_format = 'github_document')"

# create exploratory data analysis figure and write to file
results/time_A_B_distribution.png results/combined_distribution_plot_1.png: data/processed/processed_data.csv
	Rscript src/eda_generate_plots.R --input=data/processed/processed_data.csv --out_dir=results

# hypothesis_testing
results/violin_plot.png results/pvalue.csv: data/processed/processed_data.csv
	Rscript src/hypothesis_testing_script.R --input=data/processed/processed_data.csv --out_dir=results

# render final report
doc/Beijing_air_quality_report.html: doc/*.Rmd results/time_A_B_distribution.png results/combined_distribution_plot_1.png results/pvalue.csv src/references.bib
	Rscript -e "rmarkdown::render('doc/Beijing_air_quality_report.Rmd', output_format = 'html_document')"

clean_data:
		rm -rf data
		
clean_EDA: 
		rm -rf src/Beijing_air_quality_EDA.md
		rm -rf src/Beijing_air_quality_EDA_files
		rm -rf src/Beijing_air_quality_EDA.html

clean_reports:
		rm -rf results
		rm -rf doc/Beijing_air_quality_report.html
		
clean_all: clean_data clean_EDA clean_reports