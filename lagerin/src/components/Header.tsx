// Sidhuvudet högst upp: logga till vänster, meny till höger.
// "sticky top-0" gör att det ligger kvar när man scrollar.
import { useState } from 'react'

// Menylänkarna samlade i en lista, så är de lätta att ändra.
const lankar = [
  { namn: 'Tjänster', href: '#tjanster' },
  { namn: 'Projekt', href: '#galleri' },
  { namn: 'Kontakt', href: '#kontakt' },
]

export default function Header() {
  // useState håller koll på om mobilmenyn är öppen (true) eller stängd (false).
  const [menyOppen, setMenyOppen] = useState(false)

  return (
    <header className="sticky top-0 z-50 border-b border-navy/5 bg-white/80 backdrop-blur-md">
      <div className="mx-auto flex h-16 max-w-6xl items-center justify-between px-5">
        <a href="#" aria-label="LAGER:IN – till startsidan">
          <img src="/assets/lagerin-logo.png" alt="LAGER:IN" className="h-8 w-auto sm:h-9" />
        </a>

        {/* Menyn för dator (dold på mobil tack vare "hidden md:flex") */}
        <nav className="hidden items-center gap-8 md:flex">
          {lankar.map((lank) => (
            <a
              key={lank.href}
              href={lank.href}
              className="text-sm font-medium text-navy/70 transition hover:text-navy"
            >
              {lank.namn}
            </a>
          ))}
          <a
            href="#kontakt"
            className="rounded-full bg-navy px-5 py-2 text-sm font-medium text-white transition hover:bg-blue"
          >
            Begär offert
          </a>
        </nav>

        {/* Hamburgerknapp, syns bara på mobil */}
        <button
          type="button"
          className="p-2 md:hidden"
          aria-label="Öppna meny"
          aria-expanded={menyOppen}
          onClick={() => setMenyOppen(!menyOppen)}
        >
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
            {menyOppen ? <path d="M6 6l12 12M18 6L6 18" /> : <path d="M4 7h16M4 12h16M4 17h16" />}
          </svg>
        </button>
      </div>

      {/* Mobilmenyn visas bara när menyOppen är true */}
      {menyOppen && (
        <nav className="border-t border-navy/5 bg-white px-5 py-4 md:hidden">
          {lankar.map((lank) => (
            <a
              key={lank.href}
              href={lank.href}
              onClick={() => setMenyOppen(false)}
              className="block py-3 text-base font-medium text-navy"
            >
              {lank.namn}
            </a>
          ))}
        </nav>
      )}
    </header>
  )
}
