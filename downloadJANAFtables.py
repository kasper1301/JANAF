import string
import urllib

def downloadJANAFtables(letters = string.ascii_uppercase,\
                        numbers = range(1,1000),\
                        url     = "http://kinetics.nist.gov/janaf/html/",\
                        folder  = "html/"):

    for letter in letters:
        for number in numbers:
            ending      = letter + "-%03i"%number + ".html"
            currentURL  = url + ending
            try:
                htmlFile    = open(folder+ending, 'w')
                urllib.urlretrieve(currentURL, folder+ending)
                if htmlFile.close():
                    print "success: " + ending
            except IOError:
                print "non-existing file: " + ending
            
if __name__=='__main__':
    downloadJANAFtables()

