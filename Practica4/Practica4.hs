{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Redundant bracket" #-}


module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numerator

data Repositorio = Repositorio {
    nombreRepositorio :: String,
    cantidadEstrella :: Number,
    colaboradores :: [String],
    issues :: [Issue],
    pullRequests :: [PullRequest]
} deriving (Show, Eq, Ord)

data Issue = Issue {
    titulo :: String,
    etiquetas :: [String]
} deriving (Show, Eq, Ord)

data PullRequest = PullRequest {
    autor :: Autor,
    cantidadCommit :: Number,
    aceptada :: Bool,
    acciones :: Trabajo
} deriving (Show, Eq, Ord)


data Autor = Autor {
    nombreAutor :: String,
    emailAutor :: String
} deriving (Show, Eq, Ord)

--PUNTO 1

esTrending :: Repositorio -> Number
esTrending repositorio 
    | (>1000) . cantidadEstrella $ repositorio = 1000
    | (<5) . length . issues $ repositorio = (+) ((*15) . length . colaboradores $ repositorio)
                            ((*30) . length . filter aceptada . pullRequests $ repositorio)
    | otherwise = (*2) . sum . map cantidadCommit . pullRequests $ repositorio
--otherwise = (*2) . sum . pullRequest $ repositorio
-- PUNTO 2 ACCIONES PULLREQUEST
{-En el segundo punto, se pide modelar las acciones sobre los pull requests de un repositorio. Cada vez que se realiza una acción, se debe eliminar el pull request más antiguo (el primero de la lista) y luego verificar si quedan pull requests abiertos. Si no queda ninguno, el sistema debe agregar un issue titulado “Sin PRs activos” con la etiqueta “maintenance”. Las acciones posibles incluyen mergear una cantidad de pull requests pendientes, agregar commits al último pull request, cerrar todos los pull requests de un autor específico y una acción express que combine el merge de un pull request y la suma de tres commits al último pull request.-}
type Trabajo = Repositorio -> Repositorio
aplicarPullRequest :: Trabajo
aplicarPullRequest = verificarSiQuedanPullRequestPendiente . eliminarUltimoPullRequest

eliminarUltimoPullRequest :: Trabajo
eliminarUltimoPullRequest repositorio = repositorio {
    pullRequests = init . pullRequests $ repositorio
}
verificarSiQuedanPullRequestPendiente :: Trabajo
verificarSiQuedanPullRequestPendiente repositorio
    | not . null . pullRequests $ repositorio = repositorio {
        issues = issues repositorio ++ [Issue "Sin PRs activos" ["maintenance"]]
    }
    | otherwise = repositorio

mergearPullRequestPendiente :: Number -> Trabajo
mergearPullRequestPendiente cantidad repositorio = aplicarPullRequest repositorio {
    pullRequests = mergear cantidad . pullRequests $ repositorio
}
--RECURSIVIDAD
mergear :: Number -> [PullRequest] -> [PullRequest]
mergear 0 listaPullRequest = listaPullRequest
mergear _ [] = []
mergear cantidad (primerPullRequest:restoPullRequest) = primerPullRequest {aceptada = True} : mergear (cantidad -1) restoPullRequest



agregarCommitAlUltimoCommit :: Number -> Trabajo
agregarCommitAlUltimoCommit cantidadCommit repositorio = aplicarPullRequest repositorio {
    pullRequests = (++) (init . pullRequests $ repositorio) [agregarCommit cantidadCommit (last . pullRequests $ repositorio)]
    }

agregarCommit :: Number -> PullRequest -> PullRequest
agregarCommit cantidadCommit pullReq = pullReq {
    cantidadCommit = (+ cantidadCommit) . cantidadCommit $ pullReq
}

accionExpress :: Trabajo
accionExpress repositorio = mergearPullRequestPendiente 1 . agregarCommitAlUltimoCommit 3 $ repositorio

--PUNTO 3
--cantidadCommit espera un solo PR, no una lista. por eso el (())
repositorioActivo :: Repositorio -> Bool
repositorioActivo = any ((>10) . cantidadCommit) . pullRequests

repositorioBloqueado :: Repositorio -> Bool
repositorioBloqueado repositorio = (> length . colaboradores $ repositorio) . length . issues $ repositorio

githubNoEsistis :: [Repositorio] -> Bool
githubNoEsistis listaRepo = all (null . pullRequests) . filter ((>8) . length . nombreRepositorio) $ listaRepo

--PUNTO 4

pullRequestCopado :: Repositorio -> Bool
pullRequestCopado repositorio = verificacionCopado repositorio . pullRequest $ repositorio

verificacionCopado :: Repositorio -> [PullRequest] -> Bool
verificacionCopado _ [] = True
verificacionCopado repositorio (primerPullRequest:restoPullRequest) =
    mejoraPuntaje repositorio primerPullRequest && verificacionCopado (acciones primerPullRequest repositorio) restoPullRequest
--Se aplica en primerPullRequest la accionPendiente y gracias a acciones tenemos el repositorio modificado,
--Le pasamos de argumento a verificacionCopado el repositorio modificado por la accionPendiente(La cola)
mejoraPuntaje :: Repositorio -> PullRequest -> Bool
mejoraPuntaje repositorio pullAplicarLaAccionPendiente = 
    ((> esTrending repositorio) . esTrending) (acciones pullAplicarLaAccionPendiente repositorio)
--Comparamos el puntaje del repositorio antes de aplicar la accion y despues de aplicar la accion


--PUNTO 5
aplicarTodasAccionesPendientes :: Trabajo
aplicarTodasAccionesPendientes repositorio = (foldr (acciones) repositorio . pullRequest) repositorio
    -- foldr (+) base lista
    --foldr (+) 1 [2..4]
      --  (2+(3+(4+1))
{-================================================================================================================
acciones -> devuelve un repositorio modificado por la accion del pullRequest
((((acciones pullRequestConAccionAjecutar3 (acciones pullRequestConAccionAjecutar4 ( acciones pullRequestConAccionAjecutar5 repositorio))))))
================================================================================================================
-}

{-PUNTO 6: qué sucede si un repositorio tiene una cantidad infinita de acciones pendientes, y si 
sería posible computar el resultado del proceso anterior o del punto cuatro, debiendo 
justificar la respuesta utilizando el concepto de evaluación perezosa.
-}
--RESPUESTA PUNTO 6

{-
Si un repositorio tiene una cantidad infinita de acciones pendientes, el proceso de
 aplicar todas ellas (como en el punto 5 con un foldr o foldl) generalmente no termina
  nunca, ya que Haskell, aunque es un lenguaje con evaluación perezosa 
  (lazy evaluation), no puede producir un resultado final si requiere recorrer 
  toda una lista infinita —esto es un caso de divergencia. El cómputo “diverge”
   porque nunca alcanza un resultado concreto: intenta aplicar la siguiente acción 
   infinitamente, sin llegar a un valor final.

En cambio, en el punto 4, donde se verifica recursivamente si cada acción mejora el 
puntaje del repositorio, gracias a la evaluación perezosa y a la naturaleza de la 
función lógica (por ejemplo, usando &&), si en algún punto se encuentra una acción 
que no mejora el puntaje, la evaluación puede converger a False sin necesidad de
 evaluar el resto de la lista infinita. Esto es posible porque la evaluación
  perezosa de Haskell hace que solo se computen los valores necesarios para 
  determinar el resultado.-}