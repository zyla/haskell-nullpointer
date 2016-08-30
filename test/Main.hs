module Main where

import Prelude hiding (null)
import Test.Hspec
import Control.Exception
import Data.NullPointer

main = hspec $ do
    it "null is null" $ do
        isNull null `shouldBe` True

    it "other values are not null" $ do
        isNull "foo" `shouldBe` False
        isNull 42 `shouldBe` False

    it "using it throws NullPointerException" $ do
        evaluate null `shouldThrow` (== NullPointerException)