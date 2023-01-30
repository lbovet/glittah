import std/math
import model

proc distance*(p1: Particle, p2: Particle): float {.inline.} =
    return sqrt((p1$X-p2$X)*(p1$X-p2$X) + (p1$Y-p2$Y)*(p1$Y-p2$Y))