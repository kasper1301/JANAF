#=
    Functions for calculating enthalpy, entropy and chemical potential of ideal
    gases given temperature, pressure and heat capacity polynomials coefficients
=#



function calculateIdealEnthalpy(T::Float64, T_ref::Float64, h_ref, cpCoeffs)
    #=
    Calculate the ideal gas enthalpy of each component
    h_ig(T) = h_ref(T_ref) + int(cp(t)dt)_T_ref^T
    Input:
        T:          temperature [K]
        T_ref:      reference temperature [K]
        h_ref:      reference enthalpies [J mol^{-1}]
        cpCoeffs:   array with polynomial coefficients for each component
                    cp = [a1 b1 c1 ...
                          a2 b2 c2 ...
                          :  :  :   :
                          am bm cm ...]
    Output:
        h:      The enthalpy of each component [J mol^{-1}]
    =#
    n           = size(cpCoeffs,2)       # Number of coefficients in polynomials
    preFactor   = 1./[1:n]'                        # Prefactor after integration
    cpCoeffs  .*= preFactor              # Multiply coefficients with prefactors
    Tvec        = [T^i - T_ref^i for i = 1:n]# Vector of temperature differences
    h           = h_ref + cpCoeffs * Tvec                             # Enthalpy
end

function calculateIdealEnthalpy(T::Float64, T_ref::Float64, h_ref, cpCoeffs, x)
    #=
    Calculate ideal gas enthalpy of a mixture.
    H_ig = x^T * h_ig(T)
    Input:
        T:          temperature [K]
        T_ref:      reference temperature [K]
        h_ref:      reference enthalpies [J mol^{-1}]
        cpCoeffs:   array with polynomial coefficients for each component
                    cp = [a1 b1 c1 ...
                          a2 b2 c2 ...
                          :  :  :   :
                          am bm cm ...]
        x:          mole fractions or mole vector [-] or [mol]
    Output:
        h:      The enthalpy of the mixture [J mol^{-1}] or [J]
    =#
    h   = calculateIdealEnthalpy(T, T_ref,          # Enthalpy of each component
                                 h_ref, cpCoeffs)
    h   = x'*h
end

function calculateIdealEntropy(T::Float64, T_ref::Float64,
                               p, p_ref, s_ref, cpCoeffs)
    #=
    Calculate the ideal gas entropy of each component.
    s_ig = s_ref(T_ref) + int(cp(t)/t dt)_T_ref^T - R*log(p/p_ref)
    Input:
        T:          temperature [K]
        T_ref:      reference temperature [K]
        p:          pressure [Pa]
        p_ref:      reference pressure [Pa]
        s_ref:      reference entropies [J K^{-1} mol^{-1}]
        cpCoeffs:   array with polynomial coefficients for each component
                    cp = [a1 b1 c1 ...
                          a2 b2 c2 ...
                          :  :  :   :
                          am bm cm ...]
    Output:
        s:      The entropy of each component [J K^{-1} mol^{-1}]
    =#
    n           = size(cpCoeffs,2)     # The number of coefficients in cp Coeffs  
    preFactor   = 1./[1, 1:n-1]'             # The prefactor for the integration
    cpCoeffs  .*= preFactor                # Multiply coefficients and prefactor
    Tvec        = [T^i - T_ref^i for i = 0:n-1]          # Vector of temperature
    Tvec[1]     = log(T/T_ref)                                     # differences
    s           = s_ref + cpCoeffs*Tvec - 8.314472*log(p/p_ref)        # Entropy
end

function calculateIdealEntropy(T::Float64, T_ref::Float64, p, p_ref,
                               s_ref, cpCoeffs, x)
    #=
    Calculate ideal gas enthalpy of a mixture.
    S_ig = x^T * s_ig(T) + R*log(x)
    Input:
        T:          temperature [K]
        T_ref:      reference temperature [K]
        p:          pressure [Pa]
        p_ref:      reference pressure [Pa]
        s_ref:      reference entropies [J K^{-1} mol^{-1}]
        cpCoeffs:   array with polynomial coefficients for each component
                    cp = [a1 b1 c1 ...
                          a2 b2 c2 ...
                          :  :  :   :
                          am bm cm ...]
        x:          mole fractions or mole vector [-] or [mol]
    Output:
        s:      The entropy of the mixture [J K^{-1} mol^{-1}] or [J K^{-1}]
    =#
    s   = calculateIdealEntropy(T, T_ref, p , p_ref, # Entropy of each component
                                s_ref, cpCoeffs)
    s   = x'*(s + 8.314472*log(x/sum(x)))
end

function calculateIdealPotential(T, T_ref, p, p_ref, h_ref, s_ref, cpCoeffs)
    #=
    Calculate ideal gas chemical potential of each component
    mu_ig = h_ig - T*s_ig
    Input:
        T:          temperature [K]
        T_ref:      reference temperature [K]
        p:          pressure [Pa]
        p_ref:      reference pressure [Pa]
        h_ref:      reference enthalpies [J mol^{-1}]
        s_ref:      reference entropies [J K^{-1} mol^{-1}]
        cpCoeffs:   array with polynomial coefficients for each component
                    cp = [a1 b1 c1 ...
                          a2 b2 c2 ...
                          :  :  :   :
                          am bm cm ...]
    Output:
        mu:     The chemical potential of each component [J mol^{-1}]
    =#
    h   = calculateIdealEnthalpy(T, T_ref, h_ref, cpCoeffs)         # Enthalpies
    s   = calculateIdealEntropy(T, T_ref, p, p_ref, s_ref, cpCoeffs) # Entropies
    mu  = h - T*s
end
