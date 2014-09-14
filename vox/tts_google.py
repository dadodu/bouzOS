#/bin/python2

import urllib2
import urllib
import time
import os, sys


"""
    Main function.
"""
def main():
    if len(sys.argv) != 2 :
        print "Usage: tts_google.py <inputtext>"
        speak("Bonjour Roman. Il est %s heures et %s minutes." % (time.strftime('%H'), time.strftime('%M')))
    else:
        text = sys.argv[1]
        speak(text)

"""
    Sends text to Google's text to speech service
    and returns created speech (wav file).
"""
def speak(text, lang='fr', fname='result.wav', player='mplayer'):

    url = "http://translate.google.com/translate_tts"
    values = urllib.urlencode({"q": text, "textlen": len(text), "tl": lang})
    hrs = {"User-Agent": "Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.63 Safari/535.7"}
    
    limit = min(100, len(text))#100 characters is the current limit.
    text = text[0:limit]
    print "[+] Text to speech:", text
    try:
        req = urllib2.Request(url, data=values, headers=hrs)
    except:
        print "[-] Failed google request."
        return 1
    p = urllib2.urlopen(req)
    f = open(fname, 'wb')
    f.write(p.read())
    f.close()
    
    play_wav(fname, player)

"""
    Plays the wave file.
"""
def play_wav(filep, player):
    #print "[+] Playing %s file using %s." % (filep, player)
    try:
        os.system(player + " " + filep + " > /dev/null 2>&1")
    except:
        print "[-] Couldn't use %s to play file." % (player)


if(__name__ == '__main__'):
    main()
