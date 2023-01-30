type Params* = object
    # updatable
    particleCount* = 100
    worldSpeed* = 0.1

    size* = 0.008
    mass* = 0.1

    flicker* = 0.4
    flickerRatio* = 0.5

    glitter* = 0.95
    glitterRatio* = 0.6

    weirdBounce* = 1

    attraction* = 0.07
    attractionRadius* = 0.4

    # constant
    windowWidth* = 600
    windowHeight* = 600
    frameRate* = 30
    sizeFactor* = 0.2

    # calculated
    width* = 1.0
    height*: float

var params* = Params()

params.height = float(params.windowHeight) / float(params.windowWidth)
