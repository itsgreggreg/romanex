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
end
