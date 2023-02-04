import drawim, text, ../parameters, std/math, std/unicode, sugar

const visible = 3.0

type Menu* = ref object
    items*: seq[string]
    values*: seq[float]
    updaters*: seq[proc(v: float)]
    current: int
    display: float
    click: tuple[x: int, y:int] = (-1, -1)

func displayName(name: string): string =
    result = ""
    for c in name:
         if c in 'A'..'Z':
            result.add((" " & c).toLower())
         else:
            result.add(c)

proc update*(menu: Menu) =
    menu.display -= (1.0 / params.frameRate)
    if menu.display > 0 :
        stroke(0,0,0,0)
        fill(2, 0.8, 0.5, min(menu.display, 0.7))
        rectFill(0.0, params.windowHeight - 80.0,
            params.windowWidth * menu.values[menu.current], 100.0)
        Label(text: displayName(menu.items[menu.current]), x: 10, y: params.windowHeight - 10.0,
            size: 3, stroke: () => stroke(0, 0, 1.0, min(menu.display, 1.0))).draw()
        stroke(1.0)
    if isMousePressed(MOUSE_BUTTON_LEFT):
        var vec = (x: mouseX() - menu.click.x, y: mouseY() - menu.click.y)
        if abs(vec.y) > abs(vec.x) and abs(vec.y) > int(params.windowHeight / 10):
            menu.current += sgn(vec.y)
            if menu.current < 0:
                menu.current = menu.items.len - 1
            if menu.current >= menu.items.len:
                menu.current = 0
            menu.click = (mouseX(), mouseY())
        if abs(vec.x) > abs(vec.y) and abs(vec.x) > int(params.windowWidth / 10):
            menu.values[menu.current] = max(0, min(1.0, mouseX() / params.windowWidth.int))
            menu.click = (-int(params.windowWidth), mouseY())
            menu.updaters[menu.current](menu.values[menu.current])
        menu.display = visible
    else:
        menu.click = (mouseX(), mouseY())