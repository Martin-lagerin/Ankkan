// Uppmaningen längst ner ("call to action") som leder till kontakt.
// Byt ut e-postadressen nedan mot företagets riktiga adress.
const EPOST = 'info@lagerin.se'

export default function Kontakt() {
  return (
    <section id="kontakt" className="px-5 pb-20 md:pb-28">
      <div className="relative mx-auto max-w-6xl rounded-3xl bg-blue px-6 py-16 text-white sm:px-14 sm:py-20">
        <div className="max-w-2xl">
          <h2 className="font-display text-4xl leading-tight font-bold tracking-tight sm:text-6xl">
            Har du en idé eller en trasig del?
          </h2>
          <p className="mt-5 max-w-lg text-lg text-white/85">
            Berätta vad du behöver så hittar vi en lösning.
          </p>
          <div className="mt-9 flex flex-wrap items-center gap-x-6 gap-y-4">
            <a
              href={`mailto:${EPOST}`}
              className="rounded-lg bg-navy px-6 py-3.5 font-semibold text-white transition hover:bg-white hover:text-navy"
            >
              Kontakta oss
            </a>
            <a href={`mailto:${EPOST}`} className="font-mono text-sm text-white/90 underline underline-offset-4">
              {EPOST}
            </a>
          </div>
        </div>

        {/* En snedställd "lapp" i hörnet, samma stil som i hero */}
        <span className="absolute -top-3 right-6 rotate-3 rounded-md bg-cyan px-3 py-1.5 font-mono text-xs font-medium text-navy shadow-sm sm:right-12">
          skicka gärna en bild
        </span>
      </div>
    </section>
  )
}
