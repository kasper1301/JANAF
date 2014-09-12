all: downloadJANAFtables.py download delete

download: downloadJANAFtables.py
	python downloadJANAFtables.py
	
delete: deleteEmptyFiles.sh download
	sh deleteEmptyFiles.sh
	
clean:
	rm html/*
