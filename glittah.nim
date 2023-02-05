import std/random, std/math
import model, geometry, physics, lights, navigation, ui, maybe

proc init() =
    for p in 0..maxParticleCount-1:
        p$X = float(rand(params.width))
        p$Y = float(rand(params.height))
        if(params.gravity == 0.0):
            p$VX = rand(-1.0..1.0)
            p$VY = rand(-1.0..1.0)
        p$HUE = if rand(1)==1: 151 else: 0
        p$SAT = 100
        p$VAL = 1

proc update*(p: Particle) =
    # interactions
    for q in p.others():
        ?weirdBounce(distance(p, q), p, q)
        ?attractionForce(distance(p, q), p, q)
        ?chaseFactor(distance(p,q), p, q)

    # movement
    ?p.gravity()
    ?p.wallFear()
    p.position()
    p.bounceWalls()

    # look
    ?p.flickerDepth()
    ?p.glitterDepth()

ui.start(init, update)