module MonadHaha
	where
	
-- the monad
data StateMonad a = StateMonad a

-- the combinator
comb :: StateMonad a -> (a -> StateMonad b) -> StateMonad b
comb (StateMonad candidate) fn = fn candidate


-- the state	
data ProdInfo = ProdInfo (Double, String, String)

-- an accessor
price :: StateMonad ProdInfo -> Double
price (StateMonad (ProdInfo (p, _, _))) = p

-- two state transition functions
discount1 :: ProdInfo -> StateMonad ProdInfo
discount1 (ProdInfo (p, pid, sid)) = if pid == "prod1"
	then StateMonad (ProdInfo (p - 10, pid, sid))
	else StateMonad (ProdInfo (p - 20, pid, sid))

discount2 :: ProdInfo -> StateMonad ProdInfo
discount2 (ProdInfo (p, pid, sid)) = if sid == "state1"
	then StateMonad (ProdInfo (p - 20, pid, sid))
	else StateMonad (ProdInfo (p - 10, pid, sid))

-- now the application
applyDiscounts :: ProdInfo -> Double
applyDiscounts prodInfo = price ((StateMonad prodInfo) `comb` discount1 `comb` discount2)
