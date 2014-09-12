from string import ascii_uppercase
from urllib import urlretrieve

def downloadJANAFtables(letters = ascii_uppercase,\
                        numbers = range(1,1000),\
                        url     = "http://kinetics.nist.gov/janaf/html/",\
                        folder  = "html/"):
    '''
    A function that downloads the JANAF table for every component in the 
    database. 
    Input:
        [letters]:      A list/string of identifying letters in the url of the 
                        components. 
                        Defaults to [A-Z]
        [numbers]:      A list of identifying numbers in the url of the 
                        components.
                        Defaults to [1-999]
        [url]:          The url to the JANAF tables
                        Defaults to "http://kinetics.nist.gov/janaf/html/"
        [folder]:       The name of the folder where the html files are to be
                        stored.
                        Defaults to "html/"
    '''

    for letter in letters:
        for number in numbers:
            ending      = letter + "-%03i"%number + ".html"         # URL ending
            currentURL  = url + ending                                # Full URL
            try:
                htmlFile    = open(folder+ending, 'w')        # File for writing
                urlretrieve(currentURL, folder+ending)            # Retrieve URL
                if htmlFile.close():
                    print "success: " + ending                         # Success
            except IOError:
                print "non-existing file: " + ending                   # Failure
            
if __name__=='__main__':
    downloadJANAFtables()

