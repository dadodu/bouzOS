#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Wed Feb 25 15:31:20 2015

@author: rgauchi
"""


import speechd

client = speechd.SSIPClient('test')

client.set_punctuation(speechd.PunctuationMode.SOME)

client.speak("Coucou : tout le monde.")
client.speak("Comment allez vous les amis ?")

client.close()