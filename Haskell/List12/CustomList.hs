import Prelude hiding ((++), head, tail, length, null, (!!))
import qualified Prelude ((++), head, tail, length, null, (!!))
import Control.Exception

class List l where
  nil :: l a
  cons :: a -> l a -> l a
  head :: l a -> Maybe a
  tail :: l a -> Maybe (l a)
  (++) :: l a -> l a -> l a
  (!!) :: l a -> Int -> Maybe a
  toList :: [a] -> l a
  fromList :: l a -> [a]

instance List [] where
  nil = []
  cons x xs = x : xs

  head [] = Nothing
  head (x : _) = Just x

  tail []  = Nothing
  tail (_ : xs) = Just xs

  xs ++ ys = foldr (cons) ys xs

  (x : xs) !! i = if i == 0 then Just x else xs !! (i - 1)
  [] !! i = Nothing

  toList xs = xs
  fromList xs = xs

class List l => SizedList l where
  length :: l a -> Int
  null :: l a -> Bool
  null l = length l == 0

instance SizedList [] where
  length (_ : xs) = 1 + length xs
  length [] = 0

  null xs = case (head xs) of
    Just _ -> False
    Nothing -> True

data SL l a = SL { len :: Int, list :: l a } deriving (Show)

instance List l => List (SL l) where
  nil = SL { len = 0, list = nil }
  cons x (SL l xs) = SL { len = l + 1, list = cons x xs }
  head (SL _ xs) = head xs
  tail (SL l xs) = tail xs >>= \x -> Just (SL { len = l - 1, list = xs })
  (SL l1 xs) ++ (SL l2 ys) = SL { len = l1 + l2, list = xs ++ ys}
  (SL _ xs) !! i = xs !! i
  toList (x : xs) = cons x $ toList xs
  toList [] = nil
  fromList (SL _ xs) = fromList xs

instance List l => SizedList (SL l) where
  length (SL l _) = l
  null (SL l _) = l == 0

infixr 6 :+
data AppList a = Nil | Sngl a | AppList a :+ AppList a

instance Show a => Show (AppList a) where
  show xs = "[" ++ (showAux xs) ++ "]"
    where
      showAux :: Show a => (AppList a) -> String
      showAux (l :+ r) = (showAux l) ++ (showAux r)
      showAux (Sngl x) = show x ++ ","
      showAux Nil = ""

instance List AppList where
  nil = Nil
  cons x xs = (Sngl x) :+ xs

  head (l :+ r) = head l
  head (Sngl x) = Just x
  head Nil = Nothing

  tail ((Sngl x) :+ r) = Just r
  tail (l :+ r) = case tail l of
    Just xs -> Just (xs :+ r)
    Nothing -> Nothing
  tail Nil = Nothing

  l ++ r = l :+ r

  (l :+ r) !! i = if lenL > i then l !! i else r !! (i - lenL)
    where lenL = (length l)
  (Sngl x) !! 0 = Just x
  (Sngl x) !! _ = Nothing
  Nil !! _ = Nothing

  toList (x : xs) = (Sngl x) :+ (toList xs)
  toList [] = Nil

  fromList ((Sngl x) :+ r) = x : (fromList r)
  fromList (l :+ r) = (fromList l) ++ (fromList r)
  fromList Nil = []

instance SizedList AppList where
  length (l :+ r) = (length l) + (length r)
  length (Sngl _) = 1
  length Nil = 0

  null Nil = True
  null _ = False