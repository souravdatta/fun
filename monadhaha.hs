module MonadHaha
    where

-- the monad
data StateMonad a = StateMonad a

-- the combinator
comb :: StateMonad a -> (a -> StateMonad b) -> StateMonad b
comb (StateMonad candidate) fn = fn candidate

wrap :: (a -> b) -> (a -> b -> StateMonad a) -> (a -> StateMonad a)
wrap fn conv = \x -> conv x (fn x)

-- the state	
data ProdInfo = ProdInfo (Double, String, String)

-- an accessor
price :: StateMonad ProdInfo -> Double
price (StateMonad (ProdInfo (p, _, _))) = p

-- a converter
conv :: ProdInfo -> Double -> StateMonad ProdInfo
conv (ProdInfo (_, pid, sid)) newp = StateMonad (ProdInfo (newp, pid, sid))

-- two state transition functions
discount1 :: ProdInfo -> Double
discount1 (ProdInfo (p, pid, sid)) = if pid == "prod1"
    then p - 10
    else p - 20

discount2 :: ProdInfo -> Double
discount2 (ProdInfo (p, pid, sid)) = if sid == "state1"
    then p - 20
    else p - 10

-- now the application
applyDiscounts :: ProdInfo -> Double
applyDiscounts prodInfo = price ((StateMonad prodInfo) `comb` (wrap discount1 conv) `comb` (wrap discount2 conv))
