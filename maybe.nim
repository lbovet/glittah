import std/macros

macro `?`*(op: untyped) =

    op.expectKind nnkCall
    let params = newIdentNode("params")
    let name = if op[0].kind == nnkDotExpr: op[0][1] else: op[0]

    result = quote do:
        if `params`.`name` > 0:
            `op`