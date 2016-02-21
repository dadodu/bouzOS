#/bin/python2

import os, sys, getpass
import urllib2
import time


"""
    Main function.
"""
def main():
    if len(sys.argv) != 2 :
        print "Usage: tts_google.py <inputtext>"
        speak("Bonjour %s. Il est %s heures et %s minutes." % (getpass.getuser(), time.strftime('%H'), time.strftime('%M')))
    else:
        text = sys.argv[1]
        speak(text)

"""
    Sends text to Google's text to speech service
    and returns created speech (wav file).
"""
def speak(text, lang='fr', fname='result.wav', player='mplayer'):

    # 100 characters is the current limit.
    limit = min(100, len(text))
    print "[+] Text to speech:", text

    text  = text[0:limit].replace(" ","+")
    url   = "http://translate.google.com/translate_tts?ie=utf8&tl={0}&q={1}"
    hrs   = {'User-Agent': 'Mozilla/5.0'}
    hrs   = {'User-Agent': 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.63 Safari/535.7'}


    request = urllib2.Request(url.format(lang,text), headers=hrs)
    print request.read()
    try:
        #result = urllib2.urlopen(url.format(lang,text))
        result = urllib2.urlopen(request)
    except urllib2.HTTPError as e:
        print "[-] Error: %d %s." % (e.code, e.reason)
        return
    except urllib2.URLError as e:
        print "[-] Error: %s." % (e.reason)
        return

    f = open(fname, 'wb')
    f.write(result.read())
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
