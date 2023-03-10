import std/math
import model

proc velocityFactor: float = params.worldSpeed * 0.2 / params.frameRate

proc position*(p: Particle) =
    p.add(X, p$>VX * velocityFactor())
    p.add(Y, p$>VY * velocityFactor())

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
    if distance < params.particleSize * 0.1:
        p$>VX = q$VX * sgn(p$VX*q$VX).float
        p$>VY = q$VY * sgn(p$VY*q$VY).float

proc attractionForce*(distance: float, p, q: Particle) =
    if distance < params.attractionRadius:
        p$>VX += (params.attractionForce * params.particleMass * (q$X - p$X)) /
            (distance^2 * params.frameRate)
        p$>VY += (params.attractionForce * params.particleMass * (q$Y - p$Y)) /
            (distance^2 * params.frameRate)

proc gravity*(p: Particle) =
    p$>VY += params.gravity / params.frameRate