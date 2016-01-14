defmodule Romanex do
  @moduledoc """
  Encode, Decode, and Validate roman numerals.

  Letter values are:
      M = 1000, D = 500, C = 100, L = 50, X = 10, V = 5, I = 1

  The Range of Values representable by roman numerals is:
      1 - 4999
  """

  @doc "Encode an Integer into a Roman Numeral."
  @spec encode(integer) :: {atom(), String.t}
  def encode(int) when is_integer int do
    cond do
      int >= 5000 -> {:error, "too big"}
      int <= 0 -> {:error, "too small"}
      true -> {:ok, do_encode(int)}
    end
  end

  defp do_encode(int) do
    cond do
      int == 0 -> ""
      int >= 1000 -> "M" <> do_encode(int-1000)
      int >= 900 -> "CM" <> do_encode(int-900)
      int >= 500 -> "D" <> do_encode(int-500)
      int >= 400 -> "CD" <> do_encode(int-400)
      int >= 100 -> "C" <> do_encode(int-100)
      int >= 90 -> "XC" <> do_encode(int-90)
      int >= 50 -> "L" <> do_encode(int-50)
      int >= 40 -> "XL" <> do_encode(int-40)
      int >= 10 -> "X" <> do_encode(int-10)
      int == 9 -> "IX"
      int >= 5 -> "V" <> do_encode(int-5)
      int == 4 -> "IV"
      int >= 1 -> "I" <> do_encode(int-1)
    end
  end

  @doc ~S"""
  Decode a Roman Numeral into an Integer

  Returns {:ok, result} or {:error, position-of-error}

  Lesser value letters that come after Higher value letters signify addition.
  Only 1 letter may be subtracted from another letter.
      EX: 8 is VIII and never IIX.
  Subtraction can only occur if the result does not equal another letter.
      EX: 50 is never LC, as L is alread 50.
  Lesser value letters that come before Higher value letters signify subtraction.
  Letters that are repeated signify addition.
  A letter may be repeated at most 3 times.
      EX: 4 is always IV and never IIII
  Addition can only occur if the result does not equal another letter.
      EX: 100 is always C and never LL
  V, L, and D may appear only once.
  I, X, C, and M may appear up to 4 times.
  """
  @spec decode(String.t) :: {:ok | :error, non_neg_integer}
  def decode(rnum) when is_binary rnum do
      String.upcase(rnum)
      |> do_decode(0, nil, 0, 1)
  end

  defp do_decode("", total, _, subtotal,_), do: {:ok, total + subtotal}
  defp do_decode(<<rn::utf8, rns::binary>>, tot, prn, st, char) do
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
      [?I, ?X] when st == 1 -> [tot+9, 0]
      [a, ?V]  when not a in [?I,?V] and rem(tot, 10) == 0 -> [tot+st, 5]
      [?I, ?V] when st == 1 and rem(tot, 10) == 0 -> [tot+4, 0]
      [a, ?I]  when not a in [?I] and rem(tot, 5) == 0 -> [tot+st, 1]
      [?I, ?I] when st < 4 -> [tot, st+1]
      [_,_] -> [:error, char]
    end
    case [tot, st] do
      [:error, st] -> {:error, st}
      _ -> do_decode(rns, tot, rn, st, char+1)
    end
  end

  @doc "Validates a Roman Numeral. Returns true or false"
  @spec valid?(String.t) :: boolean
  def valid?(rnum) when is_binary rnum do
    poop 1, 2
    case decode(rnum) do
      {:ok, _} -> true
      _        -> false
    end
  end

  defp poop(a\\10, b\\20), do: a * b

end
