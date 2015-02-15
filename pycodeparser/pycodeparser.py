#!/usr/bin/python2.7
# -*- coding: utf-8 -*-
#
# pycodeparser.py
#
# Autor: Roman GAUCHI
# Date: 02/02/2015
# Version: 0.1
#


import sys, os, re
import getopt


#- Classes --------------------------------------------------------------------#
class pycodeparser:
    # Initiate some variables ...
    def __init__(self,file):
        self.file = file
        self.tab_import = []
        self.tab_from   = []
        self.tab_path   = []
        self.functions  = {}        # Dependencies ...
        self.classes    = {}
        self.dot = []
        self.dot.append("digraph G {")
        self.dot.append("rankdir=LR")
        self.parser_fichier()
        self.dot.append("}")
        self.dot = '\n'.join(self.dot)
        print self.dot
        self.print_dico()
    
    def parser_fichier(self):
        current_class = None
        current_funct = None
        try:
            fp = open(self.file, 'r')
        except:
            return
        
        for line in fp:
            # Path ------------------------------------------------------------#
            match = re.match(r"^sys\.path\.append\([\"']{1}([^\"']+)[\"']{1}\)", line)
            if match:
                self.tab_path.append(match.group(1))
            # Import ----------------------------------------------------------#
            if re.match(r"^import", line):
                for m in re.finditer(r"[, ]?([^,\n ]+)[, ]?", line[6:]):
                    self.tab_import.append(m.group(1))
            # From ------------------------------------------------------------#
            match = re.match(r"^from ([^ ]+) import", line)
            if match:
                self.tab_from.append(match.group(1))
                for p in self.tab_path:
                    if p[-1] == '/':
                        self.file = p+match.group(1)+".py"
                    else:
                        self.file = p+'/'+match.group(1)+".py"
                    self.parser_fichier()
            # Classes ---------------------------------------------------------#
            match = re.match(r"^class ([^\(: ]+)\(?([^\)]*)\)?:+", line)
            if match:
                try:
                    self.classes.update({match.group(1):match.group(2)})
                except:
                    self.classes.update({match.group(1):''})
                if current_class is None:
                    self.dot.append('%s;' % (match.group(1)));
                else:
                    self.dot.append('%s -> %s;' % (current_class, match.group(1)));
                current_class = match.group(1)
            # Functions -------------------------------------------------------#
            match = re.match(r"^[ \t]*def ([^\(: \t]+)[ \t]*\(?([^\)]*)\)?:+", line)
            if match:
                try:
                    self.functions.update({match.group(1):match.group(2)})
                except:
                    self.functions.update({match.group(1):''})
                if current_funct is None:
                    self.dot.append('%s;' % (match.group(1)));
                else:
                    if current_class is None:
                        self.dot.append('%s;' % (match.group(1)));
                    else:
                        self.dot.append('%s -> %s;' % (current_class, match.group(1)));
                current_funct = match.group(1)
            # Dot Graph -------------------------------------------------------#
        fp.close()
    
    def print_dico(self):
        print "path      :",self.tab_path
        print "import    :",self.tab_import
        print "from      :",self.tab_from
        print "functions :",self.functions
        print "classes   :",self.classes




#- Main Program ---------------------------------------------------------------#
def main ():
    try:
        opts, args = getopt.getopt(sys.argv[1:], "i:h", ["input=", "help"])
    except getopt.GetoptError as err:
        print str(err)
        usage()
        sys.exit(2)
    input = None
    for opt, arg in opts:
        if opt in ("-h", "--help"):
            usage()
            sys.exit()
        elif opt in ("-i", "--input"):
            input = arg
        else:
            assert False, "unhandled option"
    if input is None:
        usage()
        sys.exit()
    else:
        pycodeparser(input)
    

#- Functions ------------------------------------------------------------------#
def usage():
    print "usage: pycodeparser.py [-h] [-i] input_file.py"

#------------------------------------------------------------------------------#
if __name__=='__main__':
    main()
#------------------------------------------------------------------------------#
