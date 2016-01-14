defmodule RomanNumerals do
  @moduledoc """
  Encode, Decode, and Validate roman numerals.

  Letter values are:
      M = 1000, D = 500, C = 100, L = 50, X = 10, V = 5, I = 1

  The Range of Values representable by roman numerals is:
      1 - 4999
  """

  @doc "Encode an Integer into a Roman Numeral."
  @spec encode(integer) :: String.t
  def encode(int) when is_integer int do

  end

  @doc ~S"""
  Decode a Roman Numeral into an Integer

  Returns [:ok, result] or [:error, position-of-error]

  Lesser value letters that come after Higher value letters signify addition.
  Lesser value letters that come before Higher value letters signify subtraction.
  Only 1 letter may be subtracted from another letter.
      EX: 8 is VIII and never IIX.
  Subtraction can only occur if the result does not equal another letter.
      EX: 50 is never LC, as L is alread 50.
  V, L, and D may appear only once.
  I, X, C, and M may appear up to 4 times.
  A letter may never appear multiple times with another letter inbetween.
      EX: 9 is IX and never VIV
  """
  @spec decode(String.t) :: integer
  def decode(rnum) when is_binary rnum do
      String.upcase(rnum)
      |> String.to_char_list
      |> do_decode

  end

  defp do_decode([], total, _, subtotal,_), do: [:ok, total + subtotal]
  defp do_decode([rn|rns] , tot\\0, prn\\nil, st\\0, char\\1) do
    [tot, st] = case [prn, rn] do
      [nil, ?M] -> [tot, 1000]
      [?M, ?M] when st < 4000 -> [tot, st+1000]
      [a, ?D]  when a in [?M, nil] -> [tot+st, 500]
      [?C, ?D] when st == 100 -> [tot+400, 0]
      [a, ?C]  when a in [?M,?D,nil] and rem(tot, 500) == 0 -> [tot+st, 100]
      [?C, ?C] when st < 400 -> [tot, st+100]
      [?X, ?C] when st == 10 -> [tot+90, 0]
      [a, ?L]  when a in [?M, ?D, ?C, nil] and rem(tot, 100) == 0 -> [tot+st, 50]
      [?X, ?L] when st == 10 -> [tot+40, 0]
      [a, ?X]  when a in [?M, ?D, ?C, ?L, nil] and rem(tot, 50) == 0 -> [tot+st, 10]
      [?X, ?X] when st < 40 -> [tot, st+10]
      [?I, ?X] when st == 1 -> [tot+9, ?I, 0]
      [a, ?V]  when not a in [?I,?V] and rem(tot, 10) == 0 -> [tot+st, 5]
      [?I, ?V] when st == 1 and rem(tot, 10) == 0 -> [tot+4, 0]
      [a, ?I]  when not a in [?I] and rem(tot, 5) == 0 -> [tot+st, 1]
      [?I, ?I] when st < 4 -> [tot, st+1]
      [_,_] -> [:error, char]
    end
    case [tot, st] do
      [:error, st] -> [:error, st]
      _ -> do_decode(rns, tot, rn, st, char+1)
    end
  end

  @doc "Validates a Roman Numeral. Returns true or false"
  @spec valid?(String.t) :: boolean
  def valid?(rnum) when is_binary rnum do

  end

end
