#!/usr/bin/env python2v
# -*- coding: utf-8 -*-
"""
    Brief: Script to convert your own dictionnary in *.dic file ...
    Autor: dadodu
    Date : Created on Thu Apr  2 19:15:47 2015
"""

import sys

dictfr = "/usr/share/pocketsphinx/model/lm/fr_FR/frenchWords62K.dic"


"""
    Main function.
"""
if __name__ == '__main__':
    # Argument parsing ...
    if len(sys.argv) != 2 :
        print "Usage: french_dic_convert.py <dictionnary_file.txt>"
        sys.exit(1)

    # My dictionnary text file to convert into a *.dic file
    try:
        f_dicttxt = open(sys.argv[1], 'r')
    except:
        print "Error: openning '%s' file." % (sys.arg[1])
        sys.exit(1)

    # French dictionnary reference
    try:
        f_dictfr = open(dictfr, 'r')
    except:
        print "Error: openning french dictionnary '%s' file." % (dictfr.split("/")[-1])
        sys.exit(1)

    # Make a word list of my dictionnary to sort my word in alphabetical order
    tab_dict = []
    for line in f_dicttxt:
        tab_dict.append(line.strip())
    tab_dict.sort()

    # Read the french dictionnary to find my words
    tab_line = 0
    for line in f_dictfr:
        if tab_dict[tab_line] == line.split(" ")[0]:
            tab_dict[tab_line] = line
            if (len(tab_dict)-1) > tab_line :
                tab_line += 1

    # Then create my dictionnary in *.dic file !
    filename = sys.argv[1][:-4]+".dic"
    f = open(filename, 'w')
    f.write("%s" % (''.join(tab_dict)))

    print "Output file :",filename
    print ''.join(tab_dict)

    # Close all the openned files
    f.close()
    f_dicttxt.close()
    f_dictfr.close()
