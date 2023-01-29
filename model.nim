import std/strformat, std/unicode
import fields, parameters
export fields.Field
export parameters.params

const particleLength = ord(high(Field)) + 1
const maxParticleCount = 100000

type Particle* = range[0..maxParticleCount-1]

type Particles = array[maxParticleCount * particleLength, float]
type PageIndex = range[0..1]
type State = object
    pages: array[2, Particles]
    currentPage: PageIndex

# initialize manually so that not object state is generated in executable
var pages {.noinit}: array[2, Particles]
for p in 0..PageIndex.high:
    for i in 0..Particles.high:
        pages[p][i] = 0.0
var state {.noinit.} = State(pages: pages, currentPage: 0)

func field(index: Particle, field: Field): int {.inline} =
    index * particleLength + ord(field)

proc current(): int {.inline} =
    return state.currentPage

proc next(): int {.inline} =
    return (state.currentPage + 1) mod (high(PageIndex) + 1)

iterator particles*(): Particle {.inline} =
    for index in 0..params.particleCount-1:
        yield index

proc get*(particle: Particle, field: Field): float {.inline} =
    state.pages[current()][particle.field(field)]

proc cur*(particle: Particle, field: Field): float {.inline} =
    state.pages[next()][particle.field(field)]

proc set*(particle: Particle, field: Field, value: float) {.inline} =
    state.pages[next()][particle.field(field)] = value

proc add*(particle: Particle, field: Field, value: float) {.inline} =
    state.pages[next()][particle.field(field)] += value

proc mult*(particle: Particle, field: Field, value: float) {.inline} =
    state.pages[next()][particle.field(field)] *= value

proc show*(particle: Particle): string =
    result = &"P[{particle}]\n(current):"
    for field in Field.low..Field.high:
        result.add(toLower(&"{field}={particle.get(field):.3f} "))
    result.add &"\n(next):"
    for field in Field.low..Field.high:
        result.add(toLower(&"{field}={particle.cur(field):.3f} "))

proc roll*() =
    state.currentPage = next()