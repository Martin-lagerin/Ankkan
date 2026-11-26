// Sektionen "Vad kan vi hjälpa dig med?" med fyra tjänstekort.

// Varje tjänst beskrivs som ett objekt i en lista.
// Vill du lägga till en tjänst? Lägg bara till ett nytt objekt här.
const tjanster = [
  {
    titel: '3D-printing',
    text: 'Från digital modell till färdig produkt.',
    // "d" är ritinstruktionerna för en enkel SVG-ikon
    ikon: 'M12 3l8 4.5v9L12 21l-8-4.5v-9L12 3zm0 0v18M4 7.5l8 4.5 8-4.5',
  },
  {
    titel: 'Reservdelar',
    text: 'Ge trasiga produkter ett nytt liv.',
    ikon: 'M14.7 6.3a4 4 0 00-5.4 5.4L3 18l3 3 6.3-6.3a4 4 0 005.4-5.4l-2.5 2.5-2.4-.6-.6-2.4 2.5-2.5z',
  },
  {
    titel: 'CAD-design',
    text: 'Måttanpassade digitala modeller.',
    ikon: 'M3 21h18M5 21V8l7-5 7 5v13M9 21v-6h6v6',
  },
  {
    titel: 'Prototyper',
    text: 'Testa och utveckla dina idéer.',
    ikon: 'M9 18h6M10 21h4M12 3a6 6 0 00-3.5 10.9c.6.4 1 1.1 1 1.9V16h5v-.2c0-.8.4-1.5 1-1.9A6 6 0 0012 3z',
  },
]

export default function Tjanster() {
  return (
    // id="tjanster" gör att länken #tjanster hoppar hit
    <section id="tjanster" className="bg-mist py-24 sm:py-32">
      <div className="mx-auto max-w-6xl px-5">
        <h2 className="text-center text-3xl font-semibold tracking-tight sm:text-5xl">
          Vad kan vi hjälpa dig med?
        </h2>

        {/* Rutnät: 1 kolumn på mobil, 2 på surfplatta, 4 på dator */}
        <div className="mt-14 grid gap-5 sm:grid-cols-2 lg:grid-cols-4">
          {tjanster.map((tjanst) => (
            <div
              key={tjanst.titel}
              className="rounded-3xl bg-white p-8 shadow-sm transition hover:-translate-y-1 hover:shadow-xl hover:shadow-navy/5"
            >
              <div className="flex h-12 w-12 items-center justify-center rounded-2xl bg-gradient-to-br from-blue to-cyan text-white">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round">
                  <path d={tjanst.ikon} />
                </svg>
              </div>
              <h3 className="mt-6 text-xl font-semibold">{tjanst.titel}</h3>
              <p className="mt-2 text-navy/65">{tjanst.text}</p>
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}
