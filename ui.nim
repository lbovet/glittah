import model, drawim, control/menu, std/sequtils

proc start*(init, update: proc) =
    setFrameRate(params.frameRate.int)
    setColorMode(HSV)

    proc setup() =
        init()
        afterInit()
        background(0)

    var menu = Menu(items: toSeq(params.names()),
        values: toSeq(params.values()),
        updaters: toSeq(updaters))

    proc draw() =
        background(0)
        roll()
        for particle in particles():
            update(particle)
            stroke((particle$HUE).int, particle$SAT, particle$VAL)
            fill((particle$HUE).int, particle$SAT, particle$VAL)
            circleFill(particle$X * params.windowWidth,
                particle$Y * params.windowWidth,
                params.size * params.windowWidth * params.sizeFactor)
        menu.update()
        if isMousePressed(MOUSE_BUTTON_RIGHT):
            quit()

    run(params.windowWidth.int, params.windowHeight.int, draw, setup, name = "glittah")