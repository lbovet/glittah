import std/random, std/math
import model, geometry, physics, ui

proc init() =
    for particle in particles():
        particle.set(X, float(rand(params.width)))
        particle.set(Y, float(rand(params.height)))
        particle.set(VX, 1.0-rand(2.0))
        particle.set(VY, 1.0-rand(2.0))
        if rand(1) == 1:
            particle.set(R, 1.0)
        else:
            particle.set(G, 1.0)

proc update*(p: Particle) =
    p.inertia()
    p.position()

    for p2 in particles():
        var distance = distance(p, p2)
        if p != p2 and distance < params.size:
            if p.get(VX) != - p2.get(VX):
                p.set(VX, -p2.get(VX))
            if p.get(VY) != - p2.get(VY):
                p.set(VY, -p2.get(VY))

    p.bounceWalls()

ui.start(init, update)