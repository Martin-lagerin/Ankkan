// En liten återanvändbar "etikett" i monospace-typsnitt,
// som de tekniska lappar man ser på ritningar och 3D-skrivare.
// Används t.ex. ovanför rubriker: <Etikett>01 / Tjänster</Etikett>
import type { ReactNode } from 'react'

type Props = {
  children: ReactNode
  className?: string // valfria extra klasser
}

export default function Etikett({ children, className = '' }: Props) {
  return (
    <span
      className={`inline-block font-mono text-xs font-medium tracking-wider text-navy/60 uppercase ${className}`}
    >
      {children}
    </span>
  )
}
