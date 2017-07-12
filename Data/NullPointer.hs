{-# LANGUAGE MagicHash #-}

-- | Adds @null@ value to any Haskell data type.
module Data.NullPointer (null, isNull, NullPointerException(..)) where

import Prelude hiding (null)
import Control.Exception
import System.IO.Unsafe (unsafePerformIO)
import qualified GHC.HeapView as HV
import System.Mem.StableName

-- | The null value.
-- When forced, a NullPointerException will be thrown.
null :: a
null = throw NullPointerException
{-# NOINLINE null #-}

-- | Check whether the given value is 'null'.
isNull :: a -> Bool
isNull x = unsafePerformIO $ do

  {-
  putStrLn "nullbox"
  nullBox <- evaluate (HV.asBox null)
  box <- evaluate (HV.asBox x)

  putStrLn "x unevaluated closure"
  closure <- HV.getBoxedClosureData box
  print closure

  putStrLn "x evaluated closure"
  closure <- HV.getBoxedClosureData box
  print closure

  putStrLn "null closure"
  nullClosure <- try (evaluate =<< HV.getBoxedClosureData nullBox) :: IO (Either SomeException HV.Closure)
  print nullClosure
  -}

  snX <- makeStableName x
  result <- try (evaluate x)
  snNull <- makeStableName null
  putStrLn $ "stable names: " ++ show (hashStableName snX, hashStableName snNull)

  case result of

    Left NullPointerException -> do
      closure <- HV.getClosureData x
      putStrLn $ "x closure: " ++ show closure
      case closure of
        HV.BlackholeClosure{} -> throwIO NullPointerException
        _ -> pure True

    Right _ -> pure False

-- | Thrown on attempt to use 'null'.
data NullPointerException = NullPointerException deriving (Eq, Show)

instance Exception NullPointerException
