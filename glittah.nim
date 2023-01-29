import std/random, std/math
import model, geometry, physics, lights, ui

proc init() =
    for p in particles():
        p.set(X, float(rand(params.width)))
        p.set(Y, float(rand(params.height)))
        p.set(VX, rand(-1.0..1.0))
        p.set(VY, rand(-1.0..1.0))
        p.set(HUE, if rand(1)==1: 67 else: 0)
        p.set(SAT, 100)
        p.set(VAL, 1)

proc update*(p: Particle) =

    for q in p.others():
        if params.weirdBounce > 0: weirdBounce(distance(p, q), p, q)

    p.position()
    p.bounceWalls()
    if params.flickerRatio > 0: p.flicker()
    if params.glitterRatio > 0: p.glitter()

ui.start(init, update)