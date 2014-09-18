all: downloadJANAFtables.py deleteEmptyFiles.sh download delete

download: downloadJANAFtables.py
	./downloadJANAFtables
	
delete: deleteEmptyFiles.sh
	sh deleteEmptyFiles.sh
	
clean:
	rm html/*
