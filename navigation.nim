import model, std/math, basic2d

proc wallFear*(p: Particle) =
    var dfactor = 2.0 * params.wallFear / params.frameRate
    var wfactor = 8.0
    if p$X < 1.0 / wfactor:
        p$>VX += (1.0 - p$X) * dfactor
    if p$Y < 1.0 / wfactor:
        p$>VY += (1.0 - p$Y) * dfactor
    if p$X > 1.0 - 1.0 / wfactor:
        p$>VX -= p$X * dfactor
    if p$Y > 1.0 - 1.0 / wfactor:
        p$>VY -= p$Y * dfactor

proc close(a1: float, a2: float, r: float = 1.0): bool =
    abs(a1 - a2) < params.chaseAngle * PI * 2 * r

proc chaseFactor*(distance: float, p, q: Particle) =
    var va = vector2d(p$>VX, p$>VY)
    var pva = va.angle()
    var qa = (vector2d(q$X, q$Y) - vector2d(p$X, p$Y)).angle()
    var qva = vector2d(q$VX, q$VY).angle()
    if close(pva, qa, 2) and close(pva, qva):
        var avg = 4 * pva + qva / 5
        va.rotate(avg - pva)
        (p$>VX, p$VY) = (va.x, va.y)
