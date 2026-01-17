module Test_Entrega2 where
  
import Test.Hspec
import Entrega2
import Entrega1
import PdePreludat


testEntrega2 :: IO ()
testEntrega2 = hspec $ do
  -- [1A. INTEGRANTES 1,2,3 - ARRANCAN O NO ARRANCAN]------------------------------
  describe "1A - Arrancan o No Arrancan" $ do 
    it "Lista Mix de Autos en Buen y Mal Estado.                    Devuelve los modelos de autos en Mal Estado            " $ do 
      arrancanONoArrancan [ferrari, lamborghini, fiat, peugeot] `shouldBe` ["600", "504"]
    it "Lista de Autos en Buen Estado.                              Devuelve una lista vacia                               " $ do 
      arrancanONoArrancan [ferrari, lamborghini] `shouldBe` []


  -- [1B. INTEGRANTES 1 - GRUPO ALTO EMBOLE]---------------------------------------
  describe "1B - Grupo Alto Embole" $ do
    it "Primeros 2.             Un lambo y un ferrari desgastado.   La ferrari no da mas.               Se satisface       " $ do
      grupoAltoEmbole 2 [lamborghini, ferrari {desgasteRuedas = 20, desgasteChasis = 90}] `shouldBe` True
    it "Primeros 3.             Un lambo, un ferrari y un fiat.     Los tres dan mas.                   No se satisface    " $ do
      grupoAltoEmbole 3 [lamborghini, ferrari, fiat] `shouldBe` False
    it "Primeros 5.             Un grupo sin autos.                                                     No se satisface    " $ do
      grupoAltoEmbole 5 [] `shouldBe` False

  -- [1C. INTEGRANTES 2 - CLASICO DE CLASICOS]---------------------------------------
  describe "1C - Clasico de Clasicos" $ do
    it "Grupo donde todos los autos que cumplen el tiempo minimo son Chiche                             Se satisface       " $ do
      clasicoDeClasicos 20 [lamborghini { tiempoCarrera = 30}, ferrari { tiempoCarrera = 10, desgasteRuedas = 20, desgasteChasis = 90}] `shouldBe` True
    it "Grupo donde algun auto que cumple el tiempo minimo no es chiche                                 No se satisface    " $ do
      clasicoDeClasicos 20 [lamborghini {tiempoCarrera = 30},  ferrari {tiempoCarrera = 30, desgasteRuedas = 20, desgasteChasis = 90}]  `shouldBe` False

  -- [1D. INTEGRANTES 3 - NIVEL DE CLAVO   ]---------------------------------------
  describe "1D - nivelDeAutosClavo" $ do 
    it "Nivel Clavo de 30.      Un fiat y un lamborghini predeterminados.                               Se satisface       " $ do 
      nivelDeClavo 30 [fiat, lamborghini] `shouldBe` True
    it "Nivel Clavo de 40.      Un fiat y un lamborghini predeterminados.                               No se satisface    " $ do
      nivelDeClavo 40 [fiat, lamborghini] `shouldBe` False
    it "Nivel Clavo de 45.      Un fiat y un lamborghini predeterminados.                               No se satisface    " $ do
      nivelDeClavo 45 [fiat, lamborghini] `shouldBe` False

  -- [2A. INTEGRANTE 1 - BIRLARDISMO AUTOMOTOR - ESTAN ORDENADOS]-------------------
  describe "2A - Estan Ordenados" $ do
    it "Un grupo de autos ordenados por tiempo en carrera.                                              Se satisface       " $ do
      estanOrdenados tiempoCarrera [ferrari {tiempoCarrera = 10}, ferrari {tiempoCarrera = 20}, ferrari {tiempoCarrera = 30}] `shouldBe` True
    it "Un grupo [lamborghini, ferrari] ordenados por marca.                                            No se satisface    " $ do
      estanOrdenados marca [lamborghini, ferrari] `shouldBe` False
    it "Un solo auto.                                                                                   Se satisface       " $ do
      estanOrdenados marca [lamborghini] `shouldBe` True
    it "Una lista vacia.                                                                                Se satisface       " $ do
      estanOrdenados marca [] `shouldBe` True  

  -- [2B. INTEGRANTE 2 - BIRLARDISMO AUTOMOTOR - ALTO TOC]---------------------------------------
  describe "2B - Alto Toc" $ do
    it "Grupo de lamborghini, ferrari, fiat y peugeot.              Criterio: sin desgaste en chasis.   Se satisface       " $ do
      altoToc sinDesgasteChasis [lamborghini, ferrari, fiat, peugeot] `shouldBe` True
    it "Grupo de lamborghini y fiat.                                Criterio: sin desgaste en chasis.   No satisface       " $ do
      altoToc sinDesgasteChasis [lamborghini, fiat] `shouldBe` False
    it "Grupo formado por un lamborghini.                           Criterio: sin desgaste en chasis.   Se satisface       " $ do
      altoToc sinDesgasteChasis [lamborghini] `shouldBe` True
    it "Grupo vacio.                                                Criterio: sin desgaste en chasis.   Se satisface       " $ do
      altoToc sinDesgasteChasis [] `shouldBe` True

  -- [2C. INTEGRANTE 3 - BIRLARDISMO AUTOMOTOR - EL MAS GROSO]---------------------------------------
  describe "2C - El Mas Groso" $ do 
    it "Grupo de lamborghini con tiempo 10 y ferrari con tiempo 20. Criterio: mayor tiempo de carrera.  Devuelve el ferrari" $ do
      elMasGroso tiempoCarrera [lamborghini {tiempoCarrera = 10}, ferrari {tiempoCarrera = 20}] `shouldBe` ferrari {tiempoCarrera = 20}
    it "Grupo de ferrari y lamborghini.                             Criterio: cantidad de apodos.       Devuelve el ferrari" $ do
      elMasGroso (length.apodos) [lamborghini, ferrari] `shouldBe` ferrari

  -- [3. INTEGRANTES 1,2,3 - A LAS PISTAS Y MAS ALLA]---------------------------------------
  describe "3 - A las Pistas y Mas Alla" $ do
    it "Recorrer Pista Monza con una ferrari.                       Devuelve Tiempo de Pista    == 102                     " $ do
      tiempoCarrera (recorrerPista monza ferrari) `shouldBe` 102
    it "Recorrer Pista Monza con una ferrari.                       Devuelve Desgaste de Ruedas == 62.5                    " $ do
      desgasteRuedas (recorrerPista monza ferrari) `shouldBe` 62.5
    it "Recorrer Pista Monza con una ferrari.                       Devuelve Desgaste de Chasis == 14.75                   " $ do
      desgasteChasis (recorrerPista monza ferrari) `shouldBe` 14.75