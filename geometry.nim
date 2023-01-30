import std/math
import model

proc distance*(p1: Particle, p2: Particle): float {.inline.} =
    return sqrt((p1$X-p2$X)^2 + (p1$Y-p2$Y)^2)

proc velocity*(p: Particle): float {.inline.} =
    return sqrt(p$VX^2 + p$VY^2)