// "Så funkar det": tre enkla steg från förfrågan till färdig del.
// Ändra gärna texterna så att de beskriver hur just du jobbar.
import Etikett from './Etikett'

const steg = [
  {
    titel: 'Berätta vad du behöver',
    text: 'Skicka en skiss, ett foto på den trasiga delen eller en färdig 3D-fil.',
  },
  {
    titel: 'Vi tar fram modellen',
    text: 'Vi mäter, ritar i CAD och stämmer av med dig innan något printas.',
  },
  {
    titel: 'Printat och klart',
    text: 'Delen printas lager för lager på vår Bambu Lab P2S och lämnas eller skickas till dig.',
  },
]

export default function Process() {
  return (
    <section id="process" className="border-y border-sand bg-[#fbfaf7]">
      <div className="mx-auto max-w-6xl px-5 py-20 md:py-28">
        <Etikett>Så funkar det</Etikett>
        <h2 className="mt-4 max-w-xl font-display text-4xl leading-tight font-bold tracking-tight sm:text-5xl">
          Tre steg från idé till färdig del.
        </h2>

        {/* På dator ligger stegen bredvid varandra, på mobil under varandra */}
        <ol className="mt-12 grid gap-10 md:grid-cols-3 md:gap-8">
          {steg.map((s, index) => (
            <li key={s.titel} className="border-t-2 border-navy pt-5">
              {/* index börjar på 0, därför + 1 */}
              <span className="font-mono text-sm text-blue">Steg {index + 1}</span>
              <h3 className="mt-2 font-display text-2xl font-bold">{s.titel}</h3>
              <p className="mt-2 leading-relaxed text-navy/70">{s.text}</p>
            </li>
          ))}
        </ol>
      </div>
    </section>
  )
}
