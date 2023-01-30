import std/math
import model

var velocityFactor = params.speed / params.frameRate

proc position*(p: Particle) =
    p.add(X, p$>VX * velocityFactor)
    p.add(Y, p$>VY * velocityFactor)

proc bounceWalls*(p: Particle) =
    var x = p$>X
    var y = p$>Y
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
        p$>VX = q$VX * sgn(p$VX*q$VX).float
        p$>VY = q$VY * sgn(p$VY*q$VY).float