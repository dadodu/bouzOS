#!/usr/bin/python2.7
# -*- coding: utf-8 -*-
#
# pycodeparser.py
#
# Autor: Roman GAUCHI
# Date: 02/02/2015
# Version: 0.1
#

"""
    pycodeparser{   'file1':{
                        'import': {...},
                        'from': {...},
                        'classes':{
                            'class_1':{
                                'inheritance': {'...'},
                                'attributs': {'...'},
                                'methods':{
                                    'method_1': {'dependancies ...'}
                                    'method_2': {'...'}
                                }
                            },
                            'class_2': {...}
                        },
                        'functions':{
                            'funct_1': {'dependencies ...'}
                            'funct_2': {...}
                        },
                    },
                    'file2': {...}
                }
"""

import sys, os, re
import getopt


#- Classes --------------------------------------------------------------------#
class pycodeparser:
    # Initiate some variables ...
    def __init__(self,filename):
        self.filenamename = filename
        self.tab_import = []
        self.tab_from   = []
        self.tab_path   = []
        self.functions  = {}        # Dependencies ...
        self.methods    = {}
        self.classes    = {}
        self.dot = []
        self.dico_all = NestedDict()
        
        self.init_dico()        
        
        self.parser_fichier()
        
        self.print_dico()
    
    def init_dico(self):
        self.dico_all[self.filenamename]['import']
        self.dico_all[self.filenamename]['from']
        self.dico_all[self.filenamename]['classes']
        self.dico_all[self.filenamename]['functions']
    
    def parser_fichier(self):
        current_class = None
        current_funct = None
        current_method = None
        try:
            fp = open(self.filenamename, 'r')
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
                    self.dico_all[self.filenamename]
            # From ------------------------------------------------------------#
            match = re.match(r"^from ([^ ]+) import", line)
            if match:
                self.tab_from.append(match.group(1))
                for p in self.tab_path:
                    if p[-1] == '/':
                        self.filename = p+match.group(1)+".py"
                    else:
                        self.filename = p+'/'+match.group(1)+".py"
                    self.parser_fichier()
            # Classes ---------------------------------------------------------#
            match = re.match(r"^class ([^\(: ]+)\(?([^\)]*)\)?:+", line)
            if match:
                current_class = match.group(1)
                
                try:
                    self.classes.update({match.group(1):match.group(2)})
                    print '-->',match.group(1)
                    self.dico_all[self.filenamename]['classes'][current_class]['inheritance'] = match.group(2)
                except:
                    self.classes.update({match.group(1):''})
                    self.dico_all[self.filenamename]['classes'][current_class]['inheritance'][match.group(2)]
                
            # Functions -------------------------------------------------------#
            match = re.match(r"^def ([^\(: \t]+)[ \t]*\(?([^\)]*)\)?:+", line)
            if match:
                
                try:
                    self.dico_all[self.filenamename]['functions'][match.group(1)] = match.group(2)
                    self.functions.update({match.group(1):match.group(2)})
                    
                except:
                    self.functions.update({match.group(1):''})
                
                current_funct = match.group(1)
            # Class methods ---------------------------------------------------#
            match = re.match(r"^[ \t]+def ([^\(: \t]+)[ \t]*\(?([^\)]*)\)?:+", line)
            if match:
                self.dico_all[self.filenamename]['classes'][current_class]['methods'][match.group(1)]
                
                if current_class is None:
                    print "Gros fail !"
                
                if self.methods.has_key(current_class):
                   self.methods[current_class].append(match.group(1))
                else:
                    tmp = [match.group(1)]
                
                self.methods.update({current_class:tmp})
                current_method = match.group(1)
            
            # Dot Graph -------------------------------------------------------#
        fp.close()
    
    def print_dico(self):
        print "path      :",self.tab_path
        print "import    :",self.tab_import
        print "from      :",self.tab_from
        print "functions :",self.functions
        print "classes   :",self.classes
        print "methods   :",self.methods


class NestedDict(dict):
    """Implementation of Nested Dictionary feature."""
    def __getitem__(self, item):
        try:
            return dict.__getitem__(self, item)
        except KeyError:
            value = self[item] = type(self)()
            return value


#- Functions ------------------------------------------------------------------#
def usage():
    print "usage: pycodeparser.py [-h] [-i <input_file.py>]"

def Pretty_Display(d , indent = 0):
    """ Displaying nested dictionaries
            
    """
    for key, value in d.iteritems():
        print '\t'*indent + str(key) + ':'
        if isinstance(d[key], dict):
            Pretty_Display(d[key], indent+1)
        else:
            print '\t'*(indent+1) + str(value)

#- Main Program ---------------------------------------------------------------#
if __name__=='__main__':
    try:
        opts, args = getopt.getopt(sys.argv[1:], "i:h", ["input=", "help"])
    except getopt.GetoptError as err:
        print str(err)
        usage()
        sys.exit(2)
    input_data = None
    for opt, arg in opts:
        if opt in ("-h", "--help"):
            usage()
            sys.exit()
        elif opt in ("-i", "--input"):
            input_data = arg
        else:
            assert False, "unhandled option"
    if input_data is None:
        usage()
        sys.exit()
    else:
        a = pycodeparser(input_data)
    
    print '\nTest of function Pretty_Display\n'
    
    d = NestedDict()
    d['test']
    d['test']['yo']
    d['test']['ya']
    d['The Game']['yu']['my hands are typing words']
    Pretty_Display(a.dico_all)
#------------------------------------------------------------------------------#


#------------------------------------------------------------------------------#
