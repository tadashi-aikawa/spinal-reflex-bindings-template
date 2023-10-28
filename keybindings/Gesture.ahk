;******************************************************************
; マウスジェスチャー
;******************************************************************

doMRdr() {
    send {TAB}
}

doMRd() {
    send ^#{Right}
}

doMRu() {
    send ^#{Left}
}

doMRl() {
    if (isActive("excelVBA")) {
        send +^{F2}
    } else {
        send !{Left}
    }
}

doMRr() {
    if (isActive("eclipse") || isActive("intellij")) {
        send {F3}
    } else if (isActive("excelVBA")) {
        send +{F2}
    } else {
        send !{Right}
    }
}

doMR() {
    send {RButton}
}
