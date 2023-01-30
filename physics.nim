import std/math
import model

var velocityFactor = params.worldSpeed / params.frameRate

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

proc attraction*(distance: float, p, q: Particle) =
    if distance < params.attractionRadius:
        p$>VX += (params.attraction * params.mass * (q$X - p$X)) /
            (distance^2 * params.frameRate)
        p$>VY += (params.attraction * params.mass * (q$Y - p$Y)) /
            (distance^2 * params.frameRate)

proc gravity*(p: Particle) =
    p$>VY += params.gravity / params.frameRate