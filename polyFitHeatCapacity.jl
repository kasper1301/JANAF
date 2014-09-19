function polyFitHeatCapacity(tempMatrix, heatCapacity)
    #=
    function for creating a polynomial for calculating heat capacity.
    cp(T) = a + bT + cT^2 + ...
    Input:
        tempMatrix:     [1      T_1     T_1^2 ...
                         1      T_2     T_2^2 ...
                         :       :       :
                         1      T_n     T_n^2 ...]
        heatCapacity:   [cp_1   cp_2    cp_2  ...   cp_n]'
    Output:
        cpCoeff:        [a  b   c   ...]'
    =#
    # Linear regression: coeff = (F(T)'*F(T))^{-1}*F(T)' * cp(T)
    return (tempMatrix'*tempMatrix) \ (tempMatrix' * heatCapacity)
end
