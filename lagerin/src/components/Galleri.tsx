// Gallerisektionen "Tillverkat lager för lager."
//
// SÅ LÄGGER DU IN DINA EGNA BILDER:
// 1. Lägg bildfilen i mappen public/assets/projekt/ (t.ex. "drakhuvud.jpg").
// 2. Skriv in sökvägen i "bild" nedan, t.ex. bild: '/assets/projekt/drakhuvud.jpg'.
// Så länge "bild" är tom visas en platshållare istället.

type Projekt = {
  titel: string
  bild: string // sökväg till bilden, eller tom text ('') om bilden saknas ännu
}

const projekt: Projekt[] = [
  { titel: 'Projekt 1', bild: '' },
  { titel: 'Projekt 2', bild: '' },
  { titel: 'Projekt 3', bild: '' },
  { titel: 'Projekt 4', bild: '' },
  { titel: 'Projekt 5', bild: '' },
  { titel: 'Projekt 6', bild: '' },
]

export default function Galleri() {
  return (
    <section id="galleri" className="py-24 sm:py-32">
      <div className="mx-auto max-w-6xl px-5">
        <h2 className="text-center text-3xl font-semibold tracking-tight sm:text-5xl">
          Tillverkat lager för lager.
        </h2>
        <p className="mx-auto mt-4 max-w-xl text-center text-lg text-navy/65">
          Ett urval av delar, prototyper och modeller vi har tagit fram.
        </p>

        <div className="mt-14 grid grid-cols-2 gap-4 lg:grid-cols-3">
          {projekt.map((p) => (
            <figure key={p.titel} className="group overflow-hidden rounded-3xl bg-mist">
              {/* Om det finns en bild visas den, annars en platshållare */}
              {p.bild ? (
                <img
                  src={p.bild}
                  alt={p.titel}
                  loading="lazy"
                  className="aspect-square w-full object-cover transition duration-500 group-hover:scale-105"
                />
              ) : (
                <Platshallare />
              )}
              <figcaption className="px-5 py-4 text-sm font-medium">{p.titel}</figcaption>
            </figure>
          ))}
        </div>
      </div>
    </section>
  )
}

// En liten egen komponent för den tomma bildrutan.
// Randerna ska påminna om lagren i en 3D-print.
function Platshallare() {
  return (
    <div className="flex aspect-square w-full items-center justify-center bg-[repeating-linear-gradient(0deg,#eef2f7_0px,#eef2f7_6px,#f5f7fa_6px,#f5f7fa_12px)]">
      <span className="rounded-full bg-white/80 px-4 py-1.5 text-xs font-medium text-navy/50">
        Bild kommer snart
      </span>
    </div>
  )
}
