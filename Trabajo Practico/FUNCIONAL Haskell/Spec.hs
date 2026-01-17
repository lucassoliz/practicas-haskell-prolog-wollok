module Spec where

import Library
import Library (autoEsJoya, bautizarAuto, peugeot)
import PdePreludat
import Test.Hspec

correrTests :: IO ()
correrTests = hspec $ do
  -- [2A. TODOS LOS INTEGRANTES]---------------------------------------
  describe "2A - Saber si un auto está en buen estado" $ do
    it "Los Peugeot nunca están en buen estado" $ do
      peugeot `shouldNotSatisfy` autoEnBuenEstado
    it "Cualquier auto de marca Peugeot                                                                           " $ do
      autoEnBuenEstado peugeot `shouldBe` False
    it "Un auto con Poco  tiempo en Pista                         y un Chasis Casi Nuevo                          " $ do
      autoEnBuenEstado (lamborghini {tiempoCarrera = 99, desgasteChasis = 7}) `shouldBe` True
    it "Un auto con Poco  tiempo en Pista                         y un Chasis Desgastado                          " $ do
      autoEnBuenEstado (fiat {tiempoCarrera = 99, desgasteChasis = 33}) `shouldBe` False
    it "Un auto con Mucho tiempo en Pista,                          un Chasis Casi Nuevo y unas Ruedas Casi Nuevas" $ do
      autoEnBuenEstado (ferrari {tiempoCarrera = 130, desgasteRuedas = 50, desgasteChasis = 30}) `shouldBe` True
    it "Un auto con Poco  tiempo en Pista,                          un Chasis Desgastado y unas Ruedas Casi Nuevas" $ do
      autoEnBuenEstado (ferrari {tiempoCarrera = 15, desgasteRuedas = 50, desgasteChasis = 45}) `shouldBe` False
    it "Un auto con Mucho tiempo en Pista,                          un Chasis Casi Nuevo y unas Ruedas Desgastadas" $ do
      autoEnBuenEstado (ferrari {tiempoCarrera = 150, desgasteRuedas = 70, desgasteChasis = 30}) `shouldBe` False

  -- [2B. INTEGRANTE 1]---------------------------------------
  describe "2B - Saber si un auto no da mas" $ do
    it "Un auto con su  primer apodo empezando con 'La ',       con un Chasis Desgastado y unas Ruedas Casi Nuevas" $ do
      autoDaParaMas (ferrari {desgasteRuedas = 20, desgasteChasis = 90}) `shouldBe` False
    it "Un auto con su  primer apodo empezando con 'La ',       con un Chasis Casi Nuevo y unas Ruedas Desgastadas" $ do
      autoDaParaMas (ferrari {desgasteRuedas = 90, desgasteChasis = 20}) `shouldBe` True
    it "Un auto Sin     primer apodo empezando con 'La ',       con un Chasis Casi Nuevo y unas Ruedas Desgastadas" $ do
      autoDaParaMas (lamborghini {desgasteRuedas = 90, desgasteChasis = 20}) `shouldBe` False
    it "Un auto Sin     primer apodo empezando con 'La ',       con un Chasis Casi Nuevo y unas Ruedas Casi Nuevas" $ do
      autoDaParaMas lamborghini `shouldBe` True

  -- [2C. INTEGRANTE 2]---------------------------------------
  describe "2C - Saber si un auto es chiche" $ do
    it "Un auto con cantidad Par   de Apodos, una velocidad Impar y un Chasis Casi Nuevo                          " $ do
      esChiche lamborghini `shouldBe` True
    it "Un auto con cantidad Par   de Apodos, una velocidad Impar,  un Chasis Desgastado y unas Ruedas Desgastadas" $ do
      esChiche (lamborghini {desgasteChasis = 20, desgasteRuedas = 90}) `shouldBe` False
    it "Un auto con cantidad Impar de Apodos, una velocidad Par   y un Chasis Nuevo                               " $ do
      esChiche peugeot `shouldBe` True
    it "Un auto con cantidad Impar de Apodos, una velocidad Impar y un Chasis Nuevo                               " $ do
      esChiche ferrari `shouldBe` False

  -- [2.D INTEGRANTE 3]---------------------------------------
  describe "2D - Saber si un auto es Joya" $ do
    it "Auto Sin Desgaste y con 1 solo Apodo                                                                      " $ do
      autoEsJoya peugeot `shouldBe` True
    it "Auto Sin Desgaste y con Mas de un Apodo                                                                   " $ do
      autoEsJoya peugeot {apodos = ["El rey del desierto", "El fierro"]} `shouldBe` False
    it "Auto Con Desgaste y nombre de Marca Largo                                                                 " $ do
      autoEsJoya lamborghini `shouldBe` True
    it "Auto Con Desgaste y nombre de Marca Corto                                                                 " $ do
      autoEsJoya fiat `shouldBe` False

  -- [3A. TODOS LOS INTEGRANTES]---------------------------------------
  describe "3A - Reparar un auto" $ do
    it "Un auto con Ruedas y Chasis Desgastados                    (Test Desgaste de Ruedas)                      " $ do
      desgasteRuedas (repararAuto fiat) `shouldBe` 0
    it "Un auto con Ruedas y Chasis Desgastados                    (Test Desgaste de Chasis)                      " $ do
      desgasteChasis (repararAuto fiat) `shouldBe` 4.95
    it "Un auto con Ruedas y Chasis Nuevos                         (Test Desgaste de Ruedas)                      " $ do
      desgasteRuedas (repararAuto ferrari) `shouldBe` 0
    it "Un auto con Ruedas y Chasis Nuevos                         (Test Desgaste de Chasis)                      " $ do
      desgasteChasis (repararAuto ferrari) `shouldBe` 0

  -- [3B. INTEGRANTE 1]---------------------------------------
  describe "3B - Aplicar una penalidad X a un auto" $ do
    it "20 segundos a un auto con 10 segundos en pista                                                            " $ do
      tiempoCarrera (penalizarAuto 20 ferrari {tiempoCarrera = 10}) `shouldBe` 30
    it "0  segundos a un auto con 10 segundos en pista                                                            " $ do
      tiempoCarrera (penalizarAuto 0 ferrari {tiempoCarrera = 10}) `shouldBe` 10

  -- [3C. INTEGRANTE 2]---------------------------------------
  describe "3C - Ponerle nitro a un auto" $ do
    it "A un auto con velocidad máxima de 44 m/s                                                                  " $ do
      velocidadMaxima (ponerNitro fiat) `shouldBe` 52.8
    it "A un auto con velocidad máxima de 0 m/s                                                                   " $ do
      velocidadMaxima (ponerNitro (fiat {velocidadMaxima = 0})) `shouldBe` 0

  -- [3D. INTEGRANTE 3]---------------------------------------
  describe "3D - Bautizar un auto" $ do
    it "A un auto Con Apodos Pre-existentes                                                                       " $ do
        elem "El diablo" (apodos (bautizarAuto lamborghini "El diablo")) `shouldBe` True
    it "A un auto Sin Apodos                                                                                      " $ do
        elem "El diablo" (apodos (bautizarAuto lamborghini {apodos = []} "El diablo")) `shouldBe` True

  -- [4A. TODOS LOS INTEGRANTES]---------------------------------------
  describe "4A - Atravesar una Curva" $ do
    it "Curva peligrosa      con un auto Sin Desgastes             (Test Desgaste de Ruedas)                      " $ do
      desgasteRuedas (atravesarCurva ferrari curvaPeligrosa) `shouldBe` 15
    it "Curva peligrosa      con un auto Sin Desgastes             (Test Desgaste de Chasis)                      " $ do
      desgasteChasis (atravesarCurva ferrari curvaPeligrosa) `shouldBe` 0
    it "Curva peligrosa      con un auto a 65m/s                   (Test Tiempo en Pista)                         " $ do
      tiempoCarrera (atravesarCurva ferrari curvaPeligrosa) `shouldBe` 23.5
    it "Curva tranca         con un auto Sin Desgastes             (Test Desgaste de Ruedas)                      " $ do
      desgasteRuedas (atravesarCurva ferrari curvaTranca) `shouldBe` 15
    it "Curva tranca         con un auto Sin Desgastes             (Test Desgaste de Chasis)                      " $ do
      desgasteChasis (atravesarCurva ferrari curvaTranca) `shouldBe` 0
    it "Curva tranca         con un auto a 65m/s                   (Test Tiempo de Pista)                         " $ do
      tiempoCarrera (atravesarCurva ferrari curvaTranca) `shouldBe` 48.5

  -- [4B. INTEGRANTE 1]---------------------------------------
  describe "4B - Test de Transitar un Tramo Recto" $ do
    it "TramoRectoClassic    con un auto con un Chasis Nuevo       (Test Desgaste de Chasis)                      " $ do
      desgasteChasis (transitarTramoRetroClassic ferrari) `shouldBe` 7.15
    it "TramoRectoClassic    con un auto a 65m/s                   (Test Tiempo en Pista)                         " $ do
      tiempoCarrera (transitarTramoRetroClassic ferrari) `shouldBe` 11
    it "Tramito              con un auto con un Chasis Nuevo       (Test Desgaste de Chasis)                      " $ do
      desgasteChasis (transitarTramito ferrari) `shouldBe` 2.6
    it "Tramito              con un auto a 65m/s                   (Test Tiempo en Pista)                         " $ do
      tiempoCarrera (transitarTramito ferrari) `shouldBe` 4

  -- [4C. INTEGRANTE 2]---------------------------------------
  describe "4C - Transitar en un tramo ZigZag" $ do
    it "zigZagLoco           con un auto con un Chasis Nuevo       (Test Desgaste de Chasis)                      " $ do
      desgasteChasis (transitarZigZag ferrari zigZagLoco) `shouldBe` 5
    it "zigZagLoco           con un auto con unas Ruedas Nuevas    (Test Desgaste de Ruedas)                      " $ do
      desgasteRuedas (transitarZigZag ferrari zigZagLoco) `shouldBe` 32.5
    it "zigZagLoco           con un auto con Tiempo en Pista de 0s (Test Tiempo en Pista)                         " $ do
      tiempoCarrera (transitarZigZag ferrari zigZagLoco) `shouldBe` 15
    it "casiCurva            con un auto con un Chasis Nuevo       (Test Desgaste de Chasis)                      " $ do
      desgasteChasis (transitarZigZag ferrari casiCurva) `shouldBe` 5.0
    it "casiCurva            con un auto con unas Ruedas Nuevas    (Test Desgaste de Ruedas)                      " $ do
      desgasteRuedas (transitarZigZag ferrari casiCurva) `shouldBe` 6.5
    it "casiCurva            con un auto con Tiempo en Pista de 0s (Test Tiempo en Pista)                         " $ do
      tiempoCarrera (transitarZigZag ferrari casiCurva) `shouldBe` 3

  -- [4D. INTEGRANTE 3]---------------------------------------------------------------------
  describe "4D - Atravesar un Rulo" $ do
    it "Rulo clasico         con un auto con un Chasis Nuevo       (Test Desgaste de Chasis)                      " $ do
      desgasteChasis (atravesarRulo ferrari ruloClasico) `shouldBe` 0
    it "Rulo clasico         con un auto con unas Ruedas Nuevas    (Test Desgaste de Ruedas)                      " $ do
      desgasteRuedas (atravesarRulo ferrari ruloClasico) `shouldBe` 19.5
    it "Rulo clasico         con un auto con Tiempo en Pista de 0s (Test Tiempo en Pista)                         " $ do
      tiempoCarrera (atravesarRulo ferrari ruloClasico) `shouldBe` 1
    it "Rulo Deseo de Muerte con un auto con un Chasis Nuevo       (Test Desgaste de Chasis)                      " $ do
      desgasteChasis (atravesarRulo ferrari deseoDeMuerte) `shouldBe` 0
    it "Rulo Deseo de Muerte con un auto con unas Ruedas Nuevas    (Test Desgaste de Ruedas)                      " $ do
      desgasteRuedas (atravesarRulo ferrari deseoDeMuerte) `shouldBe` 39
    it "Rulo Deseo de Muerte con un auto con Tiempo en Pista de 0s (Test Tiempo en Pista)                         " $ do
      tiempoCarrera (atravesarRulo ferrari deseoDeMuerte) `shouldBe` 2