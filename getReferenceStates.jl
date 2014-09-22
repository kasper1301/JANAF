function getReferenceStates(files, folder)
    #=
    Function that extracts the reference temperature, enthalpy and entropy from
    csv files.
    Input:
        files:  An array with the csv files
        folder: The folder in which the files are saved
    Output:
        Tref:   Reference temperature [K]
        sref:   Reference entropy [J K^{-1} mol^{-1}]
        href:   Reference enthalpy [J mol^{-1}]
    =#
    Tref = zeros(length(files),1)                       # Initialize temperature
    sref = copy(Tref)                                       # Initialize entropy
    href = copy(Tref)                                      # Initialize enthalpy
    for i = 1:length(files)                         # Loop through all the files
        # Read the data
        data = readdlm(string(folder, files[i]),  ',', Float64; skipstart=1)
        Tref[i] = data[1]                        # Extract reference temperature
        sref[i] = data[2]                            # Extract reference entropy
        href[i] = data[3]                           # Extract reference enthalpy
    end
    return Tref, sref, href
end
