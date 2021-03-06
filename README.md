# Romanex

Encode, Decode, and Validate Roman Numerals like you're Cesar Himself.

## Usage
~~~Ruby
# Encoding from Integer to Roman Numeral
Romanex.encode 1666   #-> {:ok, "MDCLXVI"}
Romanex.encode 5000   #-> {:error, "too big"}

## Decoding. If it errors, it gives you the char it choked on.
Romanex.decode "XLII" #-> {:ok, 42}
Romanex.decode "IIV" #-> {:error, 3}

## Validating
Romanex.valid? "IIV" #-> false
Romanex.valid? "MMMMCCLXXXIX" #-> true
~~~

## Installation
  1. Add roman_numerals to your list of dependencies in `mix.exs`:

        def deps do
          [{:romanex, "~> 0.1.0"}]
        end
