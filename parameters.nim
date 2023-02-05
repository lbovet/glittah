type Params* = object
    # updatable
    worldSpeed* = 0.5
    particleCount* = 0.33 # 1.0 -> 300

    particleSize* = 0.1
    particleMass* = 0.1

    flickerDepth* = 0.4
    flickerRatio* = 0.5

    glitterDepth* = 0.95
    glitterRatio* = 0.6

    weirdBounce* = 0.0

    attractionForce* = 0.0
    attractionRadius* = 0.2

    wallFear* = 0.5

    chaseFactor* = 0.5
    chaseRadius* = 0.6
    chaseAngle* = 0.1

    gravity* = 0.0

    # constant
    windowWidth* = 1000.0
    windowHeight* = 1000.0
    frameRate* = 30.0
    sizeFactor* = 0.02

    # calculated
    width* = 1.0
    height*: float

var params* = Params()

when defined(js):
    import std/dom
    params.windowWidth = window.innerWidth.float
    params.windowHeight = window.innerHeight.float

params.height = float(params.windowHeight) / float(params.windowWidth)

const stopField = "windowWidth"

iterator names*(params: Params): string =
    for name, value in fieldPairs(params):
        when name == stopField:
            break
        else:
            yield name

iterator values*(params: Params): float =
    for name, value in fieldPairs(params):
        when name == stopField:
            break
        else:
            yield value

import std/sequtils

var updaters*: array[params.names.toSeq().len, proc(v: float)]
var i=0
for name, value in fieldPairs(params):
    when name == stopField:
        break
    else:
        var p = (proc(newValue: float) = (value = newValue))
        updaters[i] = p
        i+=1
