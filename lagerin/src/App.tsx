// App är "huvudkomponenten". Den bestämmer i vilken ordning
// sidans delar (sektioner) visas, uppifrån och ner.
import Header from './components/Header'
import Hero from './components/Hero'
import Tjanster from './components/Tjanster'
import Galleri from './components/Galleri'
import Kontakt from './components/Kontakt'
import Footer from './components/Footer'

export default function App() {
  return (
    <>
      <Header />
      <main>
        <Hero />
        <Tjanster />
        <Galleri />
        <Kontakt />
      </main>
      <Footer />
    </>
  )
}
