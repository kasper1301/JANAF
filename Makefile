all: extract

download: downloadJANAFtables
	./downloadJANAFtables
	
delete: deleteEmptyFiles
	./deleteEmptyFiles
	
extract: extractHeatCapacity
	./extractHeatCapacity
	
clean:
	rm txt/*
