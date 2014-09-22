# Includes
include("polyFitHeatCapacity.jl")                    # Least squares fit of data
include("vandermondeMatrix.jl")                    # Generate Vandermonde matrix

function calculatePolynomialCoefficients(files, names, folder,
                                         order, createPlot=true)
    #=
    Function for importing data, do a least squares fit of the data to a 
    polynomial and create plot of the data and the polynomial.
    
    The figures are saved in the folder fig/ as pdfs.
    
    Returns a coefficient matrix for all the polynomials
    
    Input:
            files:          An array with all the filenames of the data
            names:          An array with the names of the chemical components
            folder:         The folder where the data is stored.
            order:          The desired order of the polynomial
            [createPlot]:   A flag to switch plotting on/off
    Output:
            cpCoeffs:       An array with all the polynomial coefficients.
                            [a1 b1 c1 ...
                             a2 b2 c2 ...
                             :  :  :   :
                             an bn cn ...]
    =#
    cpCoeffs = zeros(length(files), order+1) # Initialize the coefficient matrix
    for i = 1:length(files)                         # Loop through all the files
        # Read the data
        data    = readdlm(string(folder, files[i]), ',', Float64; skipstart=1)
        t       = data[:,1]                                    # Temperature [K]
        cp      = data[:,2]                  # Heat capacity [J K^{-1} mol^{-1}]
        tMatrix = vandermondeMatrix(t, order)# Vandermonde matrix of temperature
        cpCoeff = polyFitHeatCapacity(tMatrix, cp)   # Calculate cp coefficients
        if createPlot                      # Create plots of regression and data
            absErr  = abs(cp - tMatrix*cpCoeff)   # Absolute error in regression

            tFit    = linspace(t[1],t[end],20000)   # Temperature for regression
            tMatrix = vandermondeMatrix(tFit, order)        # Vandermonde matrix
            figure(i)                                        # Initialize figure
                subplot(211)                         # Subplot for heat capacity
                    plot(t, cp, "kx")                                # Plot data
                    plot(tFit, tMatrix*cpCoeff, "r")           # Plot regression
                    title("\\ce{$(names[i])}")                       # Add title
                    ylabel(                                        # Add y-label
                            string("\$ c_{p,\\ce{$(names[i])}}\\quad\\left",
                                   "[\\mathrm{J K^{-1} mol^{-1}}\\right]\$")
                          )
                subplot(212)                                 # Subplot for error
                    plot(t,absErr,"k")                              # Plot error
                    xlabel("\$T \\quad [\\mathrm{K}] \$")          # Add x-label
                    ylabel(                                        # Add y-label
                           string("Absolute error \$\\quad\\left",
                                  "[\\mathrm{J K^{-1} mol^{-1}}\\right]\$")
                          )
                savefig(string("fig/", names[i], "_cp.pdf"))       # Save figure
                close()                                           # Close figure
        end
        cpCoeffs[i,:] = cpCoeff          # Add polynomial coefficients to matrix
    end
    return cpCoeffs
end
