// Gallerisektionen "Tillverkat lager för lager."
//
// SÅ LÄGGER DU IN DINA EGNA BILDER:
// 1. Lägg bildfilen i mappen public/assets/projekt/ (t.ex. "drakhuvud.jpg").
// 2. Skriv in sökvägen i "bild" nedan, t.ex. bild: '/assets/projekt/drakhuvud.jpg'.
// 3. Ändra "titel" och "info" (t.ex. material och printtid).
// Så länge "bild" är tom visas en tom byggplatta istället.
import Etikett from './Etikett'

type Projekt = {
  titel: string
  info: string // kort teknisk rad, t.ex. 'PETG · 4 h'
  bild: string // sökväg till bilden, eller tom text ('') om bilden saknas ännu
}

const projekt: Projekt[] = [
  { titel: 'Projekt 1', info: 'Material · tid', bild: '' },
  { titel: 'Projekt 2', info: 'Material · tid', bild: '' },
  { titel: 'Projekt 3', info: 'Material · tid', bild: '' },
  { titel: 'Projekt 4', info: 'Material · tid', bild: '' },
  { titel: 'Projekt 5', info: 'Material · tid', bild: '' },
]

export default function Galleri() {
  return (
    <section id="galleri" className="mx-auto max-w-6xl px-5 py-20 md:py-28">
      <Etikett>Projekt</Etikett>
      <h2 className="mt-4 font-display text-4xl leading-tight font-bold tracking-tight sm:text-5xl">
        Tillverkat lager för lager.
      </h2>

      {/*
        Rutnät där första bilden är stor (2 x 2 rutor) och resten små.
        Det ger en mer levande layout än en rad likadana rutor.
      */}
      <div className="mt-12 grid grid-cols-2 gap-4 md:grid-cols-4">
        {projekt.map((p, index) => (
          <figure key={p.titel} className={index === 0 ? 'col-span-2 row-span-2' : ''}>
            <div className="overflow-hidden rounded-2xl border border-sand">
              {p.bild ? (
                <img src={p.bild} alt={p.titel} loading="lazy" className="aspect-square w-full object-cover" />
              ) : (
                <div className="byggplatta flex aspect-square w-full items-center justify-center">
                  <span className="font-mono text-xs text-navy/40">[ bild ]</span>
                </div>
              )}
            </div>
            <figcaption className="mt-3 flex flex-col gap-0.5 sm:flex-row sm:items-baseline sm:justify-between sm:gap-2">
              <span className="font-semibold">{p.titel}</span>
              <span className="font-mono text-xs text-navy/50">{p.info}</span>
            </figcaption>
          </figure>
        ))}
      </div>
    </section>
  )
}
