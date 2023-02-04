type Params* = object
    # updatable
    particleCount* = 0.2 # 1.0 -> 500
    worldSpeed* = 0.5

    size* = 0.01
    mass* = 0.1

    flicker* = 0.4
    flickerRatio* = 0.5

    glitter* = 0.95
    glitterRatio* = 0.6

    weirdBounce* = 1.0

    attraction* = 0.06
    attractionRadius* = 0.2

    gravity* = 0.5

    # constant
    windowWidth* = 1000.0
    windowHeight* = 1000.0
    frameRate* = 30.0
    sizeFactor* = 0.2

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
