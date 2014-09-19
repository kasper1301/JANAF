function polyFitHeatCapacity(file, order=3)
    #=
    function for creating a polynomial given heat capacity data as a function of
    temperature, and an optional polynomial order.
    =#
    data            = readdlm(file, ',', Float64; skipstart=1)     # Import data
    temperature     = data[:,1]                                # Get temperature
    heatCapacity    = data[:,2]                              # Get heat capacity
    tempMatrix      = ones(size(temperature,1), order + 1)  # Temperature matrix
    for i = 1:order
        tempMatrix[:,i+1] = temperature.^(i)
    end
    # Linear regression: coeff = (F(T)'*F(T))^{-1}*F(T)' * cp(T)
    return (tempMatrix'*tempMatrix) \ (tempMatrix' * heatCapacity)
end
