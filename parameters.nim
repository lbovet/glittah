type Params* = object
    # updatable
    particleCount* = 100
    speed* = 0.2
    size* = 0.01

    flicker* = 0.4
    flickerRatio* = 0.5

    glitter* = 0.95
    glitterRatio* = 0.6

    weirdBounce* = 1

    # constant
    windowWidth* = 500
    windowHeight* = 500
    frameRate* = 30
    sizeFactor* = 0.2

    # calculated
    width* = 1.0
    height*: float

var params* = Params()

params.height = float(params.windowHeight) / float(params.windowWidth)
