// Sektionen "Vad kan vi hjälpa dig med?".
// Istället för fyra likadana kort använder vi färgblock i olika storlekar
// (ett så kallat "bento"-rutnät), vilket känns mer personligt.

// Varje tjänst beskrivs som ett objekt i en lista.
// "farg" styr blockets bakgrund och textfärg, "bred" gör blocket dubbelt så brett på dator.
const tjanster = [
  {
    nr: '01',
    titel: '3D-printing',
    text: 'Från digital modell till färdig produkt.',
    farg: 'bg-navy text-paper',
    bred: true,
  },
  {
    nr: '02',
    titel: 'Reservdelar',
    text: 'Ge trasiga produkter ett nytt liv.',
    farg: 'bg-cyan text-navy',
    bred: false,
  },
  {
    nr: '03',
    titel: 'CAD-design',
    text: 'Måttanpassade digitala modeller.',
    farg: 'bg-ice text-navy',
    bred: false,
  },
  {
    nr: '04',
    titel: 'Prototyper',
    text: 'Testa och utveckla dina idéer.',
    farg: 'bg-blue text-white',
    bred: true,
  },
]

export default function Tjanster() {
  return (
    // id="tjanster" gör att länken #tjanster hoppar hit
    <section id="tjanster" className="mx-auto max-w-6xl px-5 py-20 md:py-28">
      <div className="flex flex-wrap items-end justify-between gap-4">
        <h2 className="max-w-xl font-display text-4xl leading-tight font-bold tracking-tight sm:text-5xl">
          Vad kan vi hjälpa dig med?
        </h2>
        <span className="font-mono text-xs text-navy/50 uppercase">4 tjänster</span>
      </div>

      {/* Rutnät: 1 kolumn på mobil, 3 kolumner på dator. Breda block tar 2 kolumner. */}
      <div className="mt-12 grid gap-4 md:grid-cols-3">
        {tjanster.map((tjanst) => (
          <div
            key={tjanst.nr}
            className={`flex min-h-56 flex-col justify-between rounded-2xl p-7 ${tjanst.farg} ${
              tjanst.bred ? 'md:col-span-2' : ''
            }`}
          >
            <span className="font-mono text-sm opacity-70">{tjanst.nr}</span>
            <div>
              <h3 className="font-display text-3xl font-bold tracking-tight sm:text-4xl">
                {tjanst.titel}
              </h3>
              <p className="mt-2 text-lg opacity-80">{tjanst.text}</p>
            </div>
          </div>
        ))}
      </div>
    </section>
  )
}
