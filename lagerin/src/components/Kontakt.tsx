// Uppmaningen längst ner ("call to action") som leder till kontakt.
// Byt ut e-postadressen nedan mot företagets riktiga adress.
const EPOST = 'info@lagerin.se'

export default function Kontakt() {
  return (
    <section id="kontakt" className="px-5 pb-24 sm:pb-32">
      <div className="relative mx-auto max-w-6xl overflow-hidden rounded-[2rem] bg-navy px-6 py-20 text-center text-white sm:px-16 sm:py-24">
        {/* Dekorativt färgsken */}
        <div
          aria-hidden="true"
          className="pointer-events-none absolute -right-32 -bottom-32 h-96 w-96 rounded-full bg-gradient-to-tr from-blue to-cyan opacity-40 blur-3xl"
        />

        <h2 className="relative text-3xl font-semibold tracking-tight sm:text-5xl">
          Har du en idé eller en trasig del?
        </h2>
        <p className="relative mx-auto mt-5 max-w-xl text-lg text-white/75">
          Berätta vad du behöver så hittar vi en lösning.
        </p>
        <a
          href={`mailto:${EPOST}`}
          className="relative mt-10 inline-block rounded-full bg-white px-8 py-3.5 font-medium text-navy transition hover:bg-cyan"
        >
          Kontakta oss
        </a>
      </div>
    </section>
  )
}
