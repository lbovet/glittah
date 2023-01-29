import std/random, std/math
import model, geometry, physics, lights, ui

proc init() =
    for particle in particles():
        particle.set(X, float(rand(params.width)))
        particle.set(Y, float(rand(params.height)))
        particle.set(VX, rand(-1.0..1.0))
        particle.set(VY, rand(-1.0..1.0))
        particle.set(HUE, (if rand(1)==1: 67 else: 0))
        particle.set(SAT, 100)
        particle.set(VAL, 1)

proc update*(p: Particle) =
    for p2 in particles():
        var distance = distance(p, p2)
        if p != p2 and distance < params.size:
            p.set(VX, p2.get(VX) * sgn(p.get(VX)*p2.get(VX)).float)
            p.set(VY, p2.get(VY) * sgn(p.get(VX)*p2.get(VX)).float)

    p.position()
    p.bounceWalls()
    p.flicker()
    p.glitter()

ui.start(init, update)