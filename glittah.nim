import std/random, std/math
import model, geometry, ui

const vratio = 0.002

proc update*(particle: Particle) =
    var x = particle.get(X) + particle.get(VX) * vratio
    var y = particle.get(Y) + particle.get(VY) * vratio
    particle.set(X, x)
    particle.set(Y, y)
    var margin = params.width / 10.0;

    var r, g = 0.0
    var dx, dy = 0
    var n = 0
    for other in particles():
        var distance = distance(particle, other)
        if(distance < params.width / 20):
            n += 1
            if other.get(X) < particle.get(X):
                dx += 1
            else:
                dx -= 1
            if other.get(Y) < particle.get(Y):
                dy += 1
            else:
                dy -= 1
            r += other.get(R)
            g += other.get(G)

    if x > params.width - margin:
         particle.add(VX, -0.2, 1)
    elif x < margin:
         particle.add(VX, 0.2, 1)
    else:
        particle.add(VX, float(sgn(dx))*0.8 , 1)
    if y > params.height - margin:
         particle.add(VY, -0.2, 1)
    elif y < margin:
         particle.add(VY, 0.2, 1)
    else:
        particle.add(VY, float(sgn(dy))*0.2 ,1)

    if r > g:
        particle.add(R, 0.001)
        particle.add(G, -0.001)
    else:
        particle.add(R, -0.001)
        particle.add(G, 0.001)

proc init() =
    for particle in particles():
        particle.set(X, float(rand(params.width)))
        particle.set(Y, float(rand(params.height)))
        particle.set(VX, float(5-rand(10)))
        particle.set(VY, float(5-rand(10)))
        if rand(1) == 1:
            particle.set(R, 1.0)
        else:
            particle.set(G, 1.0)

ui.start(init, update)