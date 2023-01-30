type Params* = object
    # updatable
    particleCount* = 1000
    speed* = 0.1
    size* = 0.003

    flicker* = 0.4
    flickerRatio* = 0.5

    glitter* = 0.95
    glitterRatio* = 0.6

    weirdBounce* = 1

    # constant
    windowWidth* = 1000
    windowHeight* = 800
    frameRate* = 30
    sizeFactor* = 0.2

    # calculated
    width* = 1.0
    height*: float

var params* = Params()

params.height = float(params.windowHeight) / float(params.windowWidth)
