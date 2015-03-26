#!/bin/bash
pocketsphinx_continuous \
#    -hmm /usr/share/pocketsphinx/model/hmm/fr_FR/french_f2
    -hmm /usr/share/pocketsphinx/model/hmm/fr_FR/french_f0 \
    -dict /usr/share/pocketsphinx/model/lm/fr_FR/frenchWords62K.dic \
    -lm /usr/share/pocketsphinx/model/lm/fr_FR/french3g62K.lm.dmp \
    -samprate 16000

#    -lw 10 -feat 1s_c_d_dd -beam 1e-80 -wbeam 1e-40 \
#    -wip 0.2 \
#    -agc none -varnorm no -cmn current -inmic yes
