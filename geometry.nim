import std/math
import model

proc distance*(p1: Particle, p2: Particle): float {.inline.} =
    var x1 = p1.get(X)
    var y1 = p1.get(Y)
    var x2 = p2.get(X)
    var y2 = p2.get(Y)
    return sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2))