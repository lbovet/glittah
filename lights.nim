import std/random
import model

proc flicker*(p: Particle) =
    if rand(1.0) < params.flickerRatio:
        p.set(VAL, rand(1.0 - params.flicker))
    else:
        p.set(VAL, 1.0)

proc glitter*(p: Particle) =
    if rand(1.0) < params.glitterRatio:
        p.set(SAT, 50 * rand(1.0 - params.glitter))
    else:
        p.set(SAT, 100.0)