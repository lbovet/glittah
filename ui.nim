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
            stroke((particle$HUE).int, particle$SAT, particle$VAL)
            fill((particle$HUE).int, particle$SAT, particle$VAL)
            circleFill(particle$X * params.windowWidth,
                particle$Y * params.windowWidth,
                params.size * params.windowWidth*params.sizeFactor)
        if isMousePressed(MOUSE_BUTTON_LEFT):
            quit()

    run(params.windowWidth, params.windowHeight, draw, setup, name = "glittah")