defmodule RomanNumeralsTest do
  use ExUnit.Case

  test "Can Decode a Roman Numeral" do
    assert [:ok, 1] == RomanNumerals.decode "i"
    assert [:ok, 4] == RomanNumerals.decode "iv"
    assert [:ok, 6] == RomanNumerals.decode "vi"
    assert [:ok, 40] == RomanNumerals.decode "XL"
    assert [:ok, 1044] == RomanNumerals.decode "mxliv"
    assert [:error, 6] == RomanNumerals.decode "mxlviv"
    assert [:ok, 4000] == RomanNumerals.decode "mmmm"
    assert [:ok, 4400] == RomanNumerals.decode "mmmmcccc"
    assert [:ok, 4400] == RomanNumerals.decode "mmmmcd"
    assert [:ok, 1666] == RomanNumerals.decode "mDclXvi"
    assert [:ok, 4289] == RomanNumerals.decode "MMMMCCLXXXIX"
  end

  test "Can Encode an Integer to a Roman Numeral" do
    assert [:error, "too big"] == RomanNumerals.encode 5000
    assert [:error, "too small"] == RomanNumerals.encode 0
    assert [:error, "too small"] == RomanNumerals.encode -10
    assert [:ok, "IX"] == RomanNumerals.encode 9
    assert [:ok, "MMMM"] == RomanNumerals.encode 4000
    assert [:ok, "MMMMCM"] == RomanNumerals.encode 4900
    assert [:ok, "MMMMCMXCIX"] == RomanNumerals.encode 4999
    assert [:ok, "CDXLIV"] == RomanNumerals.encode 444
    assert [:ok, "MDCLXVI"] == RomanNumerals.encode 1666
  end
end
