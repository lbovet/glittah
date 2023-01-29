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

var pages {.noinit}: array[2, Particles]
for p in 0..PageIndex.high:
    for i in 0..Particles.high:
        pages[p][i] = 0.0

var state {.noinit.} = State(pages: pages, currentPage: 0)

type World = int

func field(index: Particle, field: Field): int {.inline} =
    index * particleLength + ord(field)

proc current(): World {.inline} =
    return state.currentPage

proc next(): World {.inline} =
    return (state.currentPage + 1) mod (high(PageIndex) + 1)

proc roll*() =
    state.currentPage = next()

iterator particles*(): Particle {.inline} =
    for index in 0..params.particleCount:
        yield index

proc get*(particle: Particle, field: Field): float {.inline} =
    state.pages[current()][particle.field(field)]

proc set*(particle: Particle, field: Field, value: float) {.inline} =
    state.pages[next()][particle.field(field)] = value

proc add*(particle: Particle, field: Field, value: float) {.inline} =
    state.pages[next()][particle.field(field)] += value

proc add*(particle: Particle, field: Field, value: float, cap: float) {.inline} =
    if abs(state.pages[next()][particle.field(field)]) < cap:
        state.pages[next()][particle.field(field)] += value

proc mult*(particle: Particle, field: Field, value: float) {.inline} =
    state.pages[next()][particle.field(field)] *= value

proc mult*(particle: Particle, field: Field, value: float, cap: float) {.inline} =
    if abs(state.pages[next()][particle.field(field)]) < cap:
        state.pages[next()][particle.field(field)] *= value
