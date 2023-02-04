import std/random
import model

proc flicker*(p: Particle) =
    if rand(1.0) < params.flickerRatio:
        p$>VAL = rand(1.0 - params.flicker)
    else:
        p$>VAL = 1.0

proc glitter*(p: Particle) =
    if rand(1.0) < params.glitterRatio:
        p$>SAT = rand(1.0 - params.glitter)
    else:
        p$>SAT = 1.0