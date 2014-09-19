def extractAll(linesOfData, componentName, dataFolder="data/"):
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
    csv.write('T[K], Cp[J K^{-1} mol^{-1}], ' +               # Write the header
              'S[J K^{-1} mol^{-1}], H[J mol^{-1}], G[J mol^{-1}]\n')
    for line in linesOfData:                        # Loop through all the lines
        try:
            data = line.split()
            temperature     = data[0]
            heatCapacity    = data[1]
            entropy         = data[2]
            enthalpy        = data[5]
            gibbsEnergy     = data[6]
            csv.write(temperature + ', ' +
                      heatCapacity + ', ' +
                      entropy + ', ' +
                      str(float(enthalpy)*1000) + ', ' +
                      str(float(gibbsEnergy)*1000) + '\n')
        except ValueError:
            csv.write(temperature + ', ' +
                      heatCapacity + ', ' +
                      entropy + ', ' +
                      'NaN, ' +
                      'NaN\n')
        except IndexError:
            pass
        except:
            print 'Error: ' + str(line) + ' for ' + componentName
    csv.close()
