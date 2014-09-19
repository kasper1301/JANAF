include("polyFitHeatCapacity.jl")
include("vandermondeMatrix.jl")

function calculatePolynomialCoefficients(files, names, folder, order, createPlot=true)                       
    cpCoeffs = zeros(length(files), order+1)
    for i = 1:length(files)
        # Read the data
        data    = readdlm(string(folder, files[i]), ',', Float64; skipstart=1)
        t       = data[:,1] # Temperature
        cp      = data[:,2] # Heat capacity
        tMatrix = vandermondeMatrix(t, order)
        # Calculate cp coefficients
        cpCoeff = polyFitHeatCapacity(tMatrix, cp)
        if createPlot
            # Calculate absolute value of the error
            absErr  = abs(cp - tMatrix*cpCoeff)
            # Plot
            tFit    = linspace(t[1],t[end],20000)
            tMatrix = vandermondeMatrix(tFit, order)
            figure(i)
            subplot(211)
            plot(t, cp, "kx")
            plot(tFit, tMatrix*cpCoeff, "r")
            title("\\ce{$(names[i])}")
            ylabel(
                    string("\$ c_{p,\\ce{$(names[i])}}\\quad",
                           "\\left[\\mathrm{J K^{-1} mol^{-1}}\\right]\$")
                  )
            subplot(212)
            plot(t,absErr,"k")
            xlabel("\$T \\quad [\\mathrm{K}] \$")
            ylabel(
                   string("Absolute error ",
                          "\$\\quad\\left[\\mathrm{J K^{-1} mol^{-1}}\\right]\$")
                  )
            savefig(string("fig/", names[i], ".pdf"))
            close()
        end
        cpCoeffs[i,:] = cpCoeff
    end
    return cpCoeffs
end
