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
