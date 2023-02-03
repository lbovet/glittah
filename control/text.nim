import drawim
import simplex

type Label* = object
    text*: string
    x*, y*: float
    size*: float
    stroke*: proc()

proc drawChar(c: char, baseX, baseY, size: float): float =
    var offset = (ord(c)-32)*112
    var vertices: int = font[offset]
    var width = size * font[offset+1].float
    var prev = (font[offset+2], font[offset+3])
    var i = 2
    while i < vertices*2:
        var curr = (font[offset+2+i], font[offset+3+i])
        if curr != (-1, -1):
            line(baseX+prev[0].float*size, baseY-prev[1].float*size,
                baseX+curr[0].float*size, baseY-curr[1].float*size)
            prev = curr
            i += 2
        else:
            prev = (font[offset+2+i+2], font[offset+3+i+2])
            i += 4

    return width

proc draw*(label: Label) =
    label.stroke()
    var x = label.x
    for c in label.text:
        x += drawChar(c, x, label.y, label.size)