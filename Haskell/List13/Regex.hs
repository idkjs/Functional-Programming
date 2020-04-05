{-# LANGUAGE FlexibleContexts #-}

import Control.Monad
import Control.Monad.State.Class

data RegExp a
  = Eps
  | Lit  (a -> Bool)
  | Or   (RegExp a) (RegExp a)
  | Cat  (RegExp a) (RegExp a)
  | Star (RegExp a)

match :: MonadPlus m => RegExp a -> [a] -> m (Maybe [a])
match Eps _ = return Nothing
match (Lit p) [] = mzero
match (Lit p) (x : xs) = if p x then return (Just xs) else mzero
match (Or r1 r2) xs = (match r1 xs) `mplus` (match r2 xs)
match (Cat r1 r2) xs = (match r1 xs) >>= \x -> case x of
  Just ys -> (match r2 ys)
  Nothing -> mzero
match (Star r) xs = do
  singleMatch <- match r xs
  case singleMatch of
    Just xs -> (match (Star r) xs) `mplus` return singleMatch
    Nothing -> mzero

isMatchedEntirely:: RegExp a -> [a] -> Bool
isMatchedEntirely r xs = any checkSuff ([] `mplus` (match r xs)) 
  where
    checkSuff :: Maybe [a] -> Bool
    checkSuff (Just xs) = length xs == 0
    checkSuff Nothing = True