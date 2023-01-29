type Params* = object

    particleCount* = 100

    windowWidth* = 500
    windowHeight* = 500
    frameRate* = 30

    width* = 1.0
    height*: float

var params* = Params()
params.height = float(params.windowHeight) / float(params.windowWidth)
