def extractAll(linesOfData, componentName, refValues, dataFolder="data/"):
    '''
    A function that converts downloaded JANAF tables from text to CSV.
    The function extracts the temperatures, heat capacities, entropy, enthalpy 
    of formation and Gibbs energy of formation. The values are written to 
    componentName.csv. Only SI units with no prefix are used.
    Input:
        txtFile:        The JANAF text file.
        componentName:  The name of the chemical component
        [dataFolder]:   The folder for the data output.
                        Defaults to "data/"
    '''
    csv     = open(dataFolder + componentName + '.csv', 'w')   # Create csv file
    csv.write('T[K],Cp[J K^{-1} mol^{-1}],' +                 # Write the header
              'S[J K^{-1} mol^{-1}],H[J mol^{-1}],G[J mol^{-1}]\n')
    href    = refValues['h']           # Get the reference enthalpy [J mol^{-1}]
    for line in linesOfData:                        # Loop through all the lines
        try:
            data = line.split()                                 # Split the line
            temperature     = data[0]                          # Temperature [K]
            heatCapacity    = data[1]        # Heat capacity [J K^{-1} mol^{-1}]
            entropy         = data[2]              # Entropy [J K^{-1} mol^{-1}]
            enthalpy        = float(data[4])*1000 + href # Enthalpy [J mol^{-1}]
            gibbsEnergy     = -float(data[3]      # Gibbs energy [J mol^{-1}]
                               ) * float(temperature) + href
            csv.write(temperature + ',' +                     # Write the values
                      heatCapacity + ',' +
                      entropy + ',' +
                      str(enthalpy) + ',' +
                      str(gibbsEnergy) + '\n')
        except ValueError:                        # Catch value errors and write 
            csv.write(temperature + ',' +    # NaN for enthalpy and gibbs energy
                      heatCapacity + ',' +
                      entropy + ',' +
                      'NaN,' +
                      'NaN\n')
        except IndexError:                    # Catch index error and do nothing
            pass
        except:                                   # Catch other errors and print
            print 'Error: ' + str(line) + ' for ' + componentName
    csv.close()                                                     # Close file
