import std/random
import model

proc flickerDepth*(p: Particle) =
    if rand(1.0) < params.flickerRatio:
        p$>VAL = rand(1.0 - params.flickerDepth)
    else:
        p$>VAL = 1.0

proc glitterDepth*(p: Particle) =
    if rand(1.0) < params.glitterRatio:
        p$>SAT = rand(1.0 - params.glitterDepth)
    else:
        p$>SAT = 1.0