// Startpunkten för appen. Den letar upp <div id="root"> i index.html
// och ritar upp vår App-komponent inuti den.
import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'

// Typsnitten laddas från npm-paket, så de fungerar även utan internet.
import '@fontsource-variable/bricolage-grotesque' // rubriker
import '@fontsource/jetbrains-mono/400.css' // små tekniska etiketter
import '@fontsource/jetbrains-mono/500.css'

import './index.css'
import App from './App'

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <App />
  </StrictMode>,
)
