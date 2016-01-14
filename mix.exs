defmodule Romanex.Mixfile do
  use Mix.Project

  def project do
    [app: :romanex,
     description: "Encode, Decode, and Validate Roman Numerals.",
     version: "0.1.0",
     elixir: "~> 1.2",
     package: package,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def package do
    [
     maintainers: ["itsgreggreg"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/itsgreggreg/romanex"}
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
     {:dialyxir, "~> 0.3", only: [:dev]},
     {:earmark, "~> 0.1", only: :dev},
     {:ex_doc, "~> 0.11", only: :dev}
    ]
  end
end
