all: run

run: main vandermondeMatrix.jl calculatePolynomialCoefficients.jl polyFitHeatCapacity.jl
	./main

download: downloadJANAFtables
	./downloadJANAFtables
	
delete: deleteEmptyFiles
	./deleteEmptyFiles
	
extract: extractHeatCapacity
	./extractHeatCapacity
	
clean:
	rm txt/*
