import std/random, std/math
import model, geometry, physics, lights, ui, maybe

proc init() =
    for p in particles():
        p$X = float(rand(params.width))
        p$Y = float(rand(params.height))
        p$VX = rand(-1.0..1.0)
        p$VY = rand(-1.0..1.0)
        p$HUE = if rand(1)==1: 67 else: 0
        p$SAT = 100
        p$VAL = 1

proc update*(p: Particle) =

    for q in p.others():
        ?weirdBounce(distance(p, q), p, q)

    p.position()
    p.bounceWalls()
    ?p.flicker()
    ?p.glitter()

ui.start(init, update)