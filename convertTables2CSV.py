def convertTables2CSV.py(txtFolder="txt/", csvFolder="csv/"):
    '''
    A function that converts downloaded JANAF tables from text to CSV.
    Input:
        [htmlFolder]:   The folder that contains the html files
        [csvFolder]:    The folder for the csv output
    '''
    from site import os
    import re
    re_name = re.compile(r'<HTML>\n<BODY>\n<TABLE BORDER=0>\n<TR>\n<TD ALIGN=LEFT COLSPAN=7>([a-zA-Z0-9]+).*</TD>')
    htmlFiles = os.listdir(htmlFolder)        # Get all the html files as a list
    
    
    
    for htmlFile in htmlFiles:
        csv = open(csvFolder + htmlFile[:-5] + '.csv', 'w')         # Create csv
        html = open(htmlFolder + htmlFile, 'r')                      # Open html
        text = html.read()                                  # Read html file
        name = re.match(re_name,text).group(1)              # Get the component name
        

if __name__=='__main__':
    convertTables2CSV()
