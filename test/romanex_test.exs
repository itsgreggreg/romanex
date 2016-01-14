defmodule RomanexTest do
  use ExUnit.Case

  test "Can Decode a Roman Numeral" do
    assert {:ok, 1} == Romanex.decode "i"
    assert {:ok, 4} == Romanex.decode "iv"
    assert {:ok, 6} == Romanex.decode "vi"
    assert {:ok, 40} == Romanex.decode "XL"
    assert {:ok, 1044} == Romanex.decode "mxliv"
    assert {:error, 6} == Romanex.decode "mxlviv"
    assert {:ok, 4000} == Romanex.decode "mmmm"
    assert {:ok, 4400} == Romanex.decode "mmmmcccc"
    assert {:ok, 4400} == Romanex.decode "mmmmcd"
    assert {:ok, 1666} == Romanex.decode "mDclXvi"
    assert {:ok, 4289} == Romanex.decode "MMMMCCLXXXIX"
  end

  test "Can Encode an Integer to a Roman Numeral" do
    assert {:error, "too big"} == Romanex.encode 5000
    assert {:error, "too small"} == Romanex.encode 0
    assert {:error, "too small"} == Romanex.encode -10
    assert {:ok, "IX"} == Romanex.encode 9
    assert {:ok, "MMMM"} == Romanex.encode 4000
    assert {:ok, "MMMMCM"} == Romanex.encode 4900
    assert {:ok, "MMMMCMXCIX"} == Romanex.encode 4999
    assert {:ok, "CDXLIV"} == Romanex.encode 444
    assert {:ok, "MDCLXVI"} == Romanex.encode 1666
  end

  test "Can Validate a Roman Numeral" do
    assert true == Romanex.valid? "i"
    assert true == Romanex.valid? "iv"
    assert true == Romanex.valid? "vi"
    assert true == Romanex.valid? "XL"
    assert true == Romanex.valid? "mxliv"
    assert false == Romanex.valid? "mxlviv"
    assert false == Romanex.valid? "mimmm"
    assert false == Romanex.valid? "mcmmmcc"
    assert true == Romanex.valid? "mmmmcd"
    assert true == Romanex.valid? "mDclXvi"
    assert true == Romanex.valid? "MMMMCCLXXXIX"
  end
end
