// Den stora inledningen överst på sidan ("hero").
export default function Hero() {
  return (
    <section className="relative overflow-hidden">
      {/* Ett mjukt färgsken i bakgrunden, bara för utseendet */}
      <div
        aria-hidden="true"
        className="pointer-events-none absolute -top-40 left-1/2 h-[500px] w-[900px] -translate-x-1/2 rounded-full bg-gradient-to-r from-blue/15 to-cyan/20 blur-3xl"
      />

      <div className="relative mx-auto max-w-4xl px-5 pt-24 pb-28 text-center sm:pt-32 sm:pb-36">
        <p className="text-xs font-semibold tracking-[0.25em] text-blue sm:text-sm">
          3D PRINTING · CAD · PROTOTYPER · DELAR
        </p>

        <h1 className="mt-6 text-5xl font-semibold tracking-tight sm:text-7xl">
          Från idé till{' '}
          <span className="bg-gradient-to-r from-blue to-cyan bg-clip-text text-transparent">
            verklighet.
          </span>
        </h1>

        <p className="mx-auto mt-6 max-w-2xl text-lg text-navy/70 sm:text-xl">
          Vi skapar nya delar, återskapar trasiga komponenter och förvandlar dina idéer till
          fysiska produkter.
        </p>

        {/* Två knappar. På mobil hamnar de under varandra, på större skärm bredvid. */}
        <div className="mt-10 flex flex-col items-center justify-center gap-3 sm:flex-row">
          <a
            href="#kontakt"
            className="w-full rounded-full bg-blue px-8 py-3.5 font-medium text-white shadow-lg shadow-blue/25 transition hover:bg-navy sm:w-auto"
          >
            Begär offert
          </a>
          <a
            href="#tjanster"
            className="w-full rounded-full border border-navy/15 px-8 py-3.5 font-medium text-navy transition hover:border-navy/40 sm:w-auto"
          >
            Våra tjänster
          </a>
        </div>
      </div>
    </section>
  )
}
