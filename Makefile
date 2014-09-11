all: downloadJANAFtables.py download

download: downloadJANAFtables.py
	python downloadJANAFtables.py
	
clean:
	rm html/*
