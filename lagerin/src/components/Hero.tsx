// Den stora inledningen överst på sidan ("hero").
// Vänster: rubrik och knappar. Höger: en bild på ett riktigt projekt.
import Etikett from './Etikett'

// Byt till en egen bild, t.ex. '/assets/projekt/hero.jpg'.
// Så länge den är tom visas en byggplatta med mått-etiketter istället.
const HERO_BILD = ''

export default function Hero() {
  return (
    <section className="mx-auto grid max-w-6xl items-center gap-12 px-5 pt-14 pb-20 md:grid-cols-[1.1fr_1fr] md:pt-20 md:pb-28">
      <div>
        <Etikett>3D printing · CAD · Prototyper · Delar</Etikett>

        <h1 className="mt-5 font-display text-[3.25rem] leading-[0.95] font-bold tracking-tight sm:text-7xl lg:text-[5.5rem]">
          Från idé till verklighet.
        </h1>

        <p className="mt-6 max-w-md text-lg leading-relaxed text-navy/75">
          Vi skapar nya delar, återskapar trasiga komponenter och förvandlar dina idéer till
          fysiska produkter.
        </p>

        <div className="mt-9 flex flex-wrap items-center gap-x-6 gap-y-4">
          <a
            href="#kontakt"
            className="rounded-lg bg-blue px-6 py-3.5 font-semibold text-white transition hover:bg-navy"
          >
            Begär offert
          </a>
          <a
            href="#tjanster"
            className="font-semibold text-navy underline decoration-blue decoration-2 underline-offset-4 transition hover:text-blue"
          >
            Våra tjänster →
          </a>
        </div>

        <p className="mt-10 font-mono text-xs text-navy/50">
          Verkstad på Lidingö, Stockholm
        </p>
      </div>

      {/* Bilden till höger, något snedställd som ett foto på en anslagstavla */}
      <div className="relative mx-auto w-full max-w-md md:max-w-none">
        <div className="relative aspect-[4/5] overflow-hidden rounded-2xl border border-sand md:rotate-[1.5deg]">
          {HERO_BILD ? (
            <img src={HERO_BILD} alt="Ett av våra 3D-printade projekt" className="h-full w-full object-cover" />
          ) : (
            <div className="byggplatta flex h-full w-full items-center justify-center">
              <span className="font-mono text-xs text-navy/40">[ din bild här ]</span>
            </div>
          )}
        </div>

        {/* Små "lappar" med tekniska fakta, för en lekfull, verkstadsaktig känsla.
            Ändra texterna till det som stämmer för dina skrivare och material. */}
        <span className="absolute -top-3 left-4 -rotate-3 rounded-md bg-cyan px-3 py-1.5 font-mono text-xs font-medium text-navy shadow-sm">
          printat på Bambu Lab P2S
        </span>
        <span className="absolute right-4 -bottom-4 rotate-2 rounded-md bg-navy px-3 py-1.5 font-mono text-xs font-medium text-paper shadow-sm">
          lager för lager
        </span>
      </div>
    </section>
  )
}
