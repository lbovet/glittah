import model, drawim, std/random

proc start*(init, update: proc) =
    setFrameRate(params.frameRate)
    setColorMode(HSV)

    proc setup() =
        init()
        afterInit()
        background(0)

    proc draw() =
        background(0)
        roll()
        for particle in particles():
            update(particle)
            stroke(particle.get(HUE).int, particle.get(SAT), particle.get(VAL))
            fill(particle.get(HUE).int, particle.get(SAT), particle.get(VAL))
            circleFill(particle.get(X)*params.windowWidth,
                particle.get(Y)*params.windowWidth,
                params.size*params.windowWidth*params.sizeFactor)
        if isMousePressed(MOUSE_BUTTON_LEFT):
            quit()

    run(params.windowWidth, params.windowHeight, draw, setup, name = "glittah")