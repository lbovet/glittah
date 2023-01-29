import model, drawim, std/random

proc start*(init, update: proc) =
    proc setup() =
        init()
        background(0)

    setFrameRate(params.frameRate)

    proc draw() =
        background(0)
        roll()
        for particle in particles():
            update(particle)
            var blink = float(rand(3))/3.0
            var r = (blink*min(1.0,particle.get(R))) + 0.2
            var g = (blink*min(1.0,particle.get(G))) + 0.2
            stroke(r, g, 0.2)
            fill(r, g, 0.2)
            circleFill(particle.get(X)*params.windowWidth, particle.get(Y)*params.windowWidth, 1)
        if isMousePressed(MOUSE_BUTTON_LEFT):
            quit()

    run(params.windowWidth, params.windowHeight, draw, setup, name = "glittah")