// Sidfoten längst ner på sidan.
export default function Footer() {
  return (
    <footer className="bg-navy text-paper">
      <div className="mx-auto max-w-6xl px-5 pt-14 pb-8">
        {/* Stort ordmärke som avslutning */}
        <p className="font-display text-6xl font-bold tracking-tight sm:text-8xl">LAGER:IN</p>

        <div className="mt-10 flex flex-col gap-2 border-t border-paper/15 pt-6 font-mono text-xs text-paper/60 sm:flex-row sm:justify-between">
          <p>Lidingö · Stockholm · Sverige</p>
          <p>© 2026 LAGER:IN</p>
        </div>
      </div>
    </footer>
  )
}
