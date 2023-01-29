import std/math
import model

var velocityFactor = params.speed / params.frameRate

proc position*(p: Particle) =
    p.add(X, p.cur(VX) * velocityFactor)
    p.add(Y, p.cur(VY) * velocityFactor)

proc bounceWalls*(p: Particle) =
    var x = p.cur(X)
    var y = p.cur(Y)
    if x > params.width:
        p.mult(VX, -1)
    if x < 0:
        p.mult(VX, -1)
    if y > params.height:
        p.mult(VY, -1)
    elif y < 0:
        p.mult(VY, -1)

proc weirdBounce*(distance: float, p, q: Particle) =
    if distance < params.size:
        p.set(VX, q.get(VX) * sgn(p.get(VX)*q.get(VX)).float)
        p.set(VY, q.get(VY) * sgn(p.get(VX)*q.get(VX)).float)