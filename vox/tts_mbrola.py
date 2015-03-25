#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Wed Mar 25 15:31:20 2015

@author: rgauchi
"""

import os, sys

MBROLA_DIR  = "/usr/share/mbrola/"
MBROLA_DB   = "fr1/fr1"

OUTPUT_PHO  = "result.pho"
OUTPUT_WAV  = "result.wav"

"""
    Main function.
"""
def main():
    if len(sys.argv) != 2 :
        print "Usage: tts_mbrola.py <text>"
        try:
            f = open("speech.txt", 'r')
        except:
            print "Erreur: open file."
            sys.exit(1)
        speak(f.read())
        f.close()
    else:
        speak(sys.argv[1])


"""
    Sends text to espeak which generate a phonetic file (result.pho), mbrola 
    generate the audio result (wav file) and the player read it.
"""
def speak(text, player='aplay'):

    print "[+] Text to speech:", text
    
    os.system("espeak -m -v mb/mb-fr1 -s130 -p40 -q --pho \"%s\" > %s" % (text, OUTPUT_PHO))
    os.system("mbrola %s %s %s" % (MBROLA_DIR+MBROLA_DB, OUTPUT_PHO, OUTPUT_WAV))
    # Reads
    os.system("%s %s" % (player, OUTPUT_WAV))


if(__name__ == '__main__'):
    main()
