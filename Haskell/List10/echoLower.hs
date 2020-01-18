import Data.Char

echoLower :: IO ()
echoLower = getLine >>= \inp -> putStrLn (map toLower inp)