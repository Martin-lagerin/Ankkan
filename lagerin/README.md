# LAGER:IN – hemsida

Företagshemsida för LAGER:IN (3D-printing, CAD, prototyper och reservdelar, Lidingö).
Byggd med **React + TypeScript + Vite + Tailwind CSS**. Bara frontend, ingen server behövs.

## Kom igång (Windows + VS Code)

1. Installera **Node.js** (LTS-versionen) från https://nodejs.org. Starta om VS Code efteråt.
2. Öppna mappen `lagerin` i VS Code (*File → Open Folder*).
3. Öppna en terminal i VS Code (*Terminal → New Terminal*) och kör:

   ```bash
   npm install
   ```

   Det laddar ner allt projektet behöver till mappen `node_modules` (görs bara en gång).
4. Starta utvecklingsservern:

   ```bash
   npm run dev
   ```

5. Öppna adressen som visas (oftast http://localhost:5173) i webbläsaren.
   När du sparar en fil uppdateras sidan direkt. Stoppa servern med `Ctrl + C`.

Övriga kommandon:

| Kommando          | Vad det gör                                               |
| ----------------- | --------------------------------------------------------- |
| `npm run build`   | Kontrollerar koden och bygger en färdig sida i `dist/`.  |
| `npm run preview` | Visar den byggda sidan lokalt, för en sista koll.         |

## Mappstruktur

```
lagerin/
├── index.html            ← HTML-skalet. Här finns sidans titel och ikon.
├── package.json          ← Lista över paket och kommandon (npm run …).
├── vite.config.ts        ← Inställningar för Vite (kopplar in React och Tailwind).
├── tsconfig.json         ← Inställningar för TypeScript.
├── public/
│   └── assets/
│       ├── lagerin-logo.png   ← Loggan
│       ├── lagerin-ikon.png   ← Ikonen i webbläsarfliken
│       └── projekt/           ← Lägg dina projektbilder här
└── src/
    ├── main.tsx          ← Startpunkten. Kopplar React till index.html.
    ├── App.tsx           ← Bestämmer ordningen på sidans delar.
    ├── index.css         ← Tailwind + våra färger och typsnitt.
    └── components/       ← En fil per del av sidan:
        ├── Etikett.tsx   ← Liten återanvändbar etikett i monospace
        ├── Header.tsx    ← Logga och meny (med mobilmeny)
        ├── Hero.tsx      ← "Från idé till verklighet." + stor bild
        ├── Tjanster.tsx  ← De fyra tjänsterna som färgblock
        ├── Process.tsx   ← "Så funkar det", tre steg
        ├── Galleri.tsx   ← "Tillverkat lager för lager."
        ├── Kontakt.tsx   ← "Har du en idé eller en trasig del?"
        └── Footer.tsx    ← Sidfoten
```

## Vanliga ändringar

- **Lägga in egna bilder i galleriet:** lägg bilden i `public/assets/projekt/` och fyll i
  `bild: '/assets/projekt/dittnamn.jpg'` i listan överst i `src/components/Galleri.tsx`.
- **Byta bilden i toppen:** sätt `HERO_BILD` överst i `src/components/Hero.tsx`.
- **Byta e-postadress:** ändra `EPOST` överst i `src/components/Kontakt.tsx`.
- **Ändra färger:** ändra värdena under `@theme` i `src/index.css`.
- **Typsnitt:** rubriker och text använder *Bricolage Grotesque*, små tekniska etiketter
  *JetBrains Mono*. De installeras via npm och laddas i `src/main.tsx`.
- **Ändra texter:** texterna står direkt i komponentfilerna i `src/components/`.

## Lite om Tailwind

Istället för att skriva CSS i en separat fil sätter man små färdiga klasser direkt i
`className`. Exempel: `rounded-full bg-blue px-8 py-3 text-white` betyder rundade hörn,
blå bakgrund, luft på sidorna och uppe/nere samt vit text. Prefix som `sm:`, `md:` och
`lg:` betyder "från den skärmbredden och uppåt", och så gör vi sidan mobilanpassad.

## Publicera på Cloudflare Pages (senare)

Byggkommando: `npm run build` · Mapp att publicera: `dist` · Rotmapp: `lagerin`
