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

var refVal: float

proc update*(menu: Menu) =
    menu.display -= (1.0 / params.frameRate)
    if menu.display > 0 :
        stroke(0,0,0,0)
        fill(2, 0.8, 0.5, min(menu.display, 0.7))
        const menuHeight = 36.0
        rectFill(0.0, params.windowHeight - menuHeight,
            params.windowWidth * menu.values[menu.current], menuHeight)
        Label(text: displayName(menu.items[menu.current]), x: 10, y: params.windowHeight - menuHeight/4,
            size: menuHeight/36, stroke: () => stroke(0, 0, 1.0, min(menu.display, 1.0))).draw()
        stroke(1.0)
    if isMousePressed(MOUSE_BUTTON_LEFT):
        if menu.click == (-1, -1):
            menu.click = (mouseX(), mouseY())
        var vec = (x: mouseX() - menu.click.x, y: mouseY() - menu.click.y)
        if abs(vec.y) > abs(vec.x) and abs(vec.y) > 40 and refVal == -1:
            menu.current += sgn(vec.y)
            if menu.current < 0:
                menu.current = menu.items.len - 1
            if menu.current >= menu.items.len:
                menu.current = 0
            menu.click = (mouseX(), mouseY())
        if abs(vec.x) > abs(vec.y) and abs(vec.x) > 20 or refVal != -1:
            if refVal == -1.0:
                refVal = menu.values[menu.current]
            menu.values[menu.current] = max(0, min(1.0, refVal + vec.x / params.windowWidth.int))
            menu.updaters[menu.current](menu.values[menu.current])
        menu.display = visible
    else:
        menu.click = (-1, -1)
        refVal = -1
