#!/usr/bin/ python2

"""
    Brief: Some Testing functions for pocketsphinx continuous program.
    Autor: dadodu
    Date : 01/04/2015
"""

import sys, time
import pocketsphinx as ps
import wave, pyaudio


hmdir  = "/usr/share/pocketsphinx/model/hmm/fr_FR/french_f0"
lmd    = "/usr/share/pocketsphinx/model/lm/fr_FR/french3g62K.lm.dmp"
dictd  = "/usr/share/pocketsphinx/model/lm/fr_FR/frenchWords62K.dic"

"""
    Decode a wavfile with standard pocketsphinx continuous program.
"""
def decodeSpeech(wavfile):
    
    """
        optimisation : http://cmusphinx.sourceforge.net/wiki/pocketsphinxhandhelds
    """
    speechRec = ps.Decoder(hmm = hmdir, lm = lmd, dict = dictd, logfn = "/dev/null")
    f_wavfile = file(wavfile,'rb')
    f_wavfile.seek(44)
    speechRec.decode_raw(f_wavfile)
    hyp, uttid, score = speechRec.get_hyp()
    
    print 'Result : "'+hyp+'"'

if __name__ == "__main__":
    
    t_start = time.time()
    decodeSpeech(sys.argv[1])
    print "Decoded in %.2f seconds." % (time.time()-t_start)

