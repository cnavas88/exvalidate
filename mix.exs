defmodule Exvalidate.MixProject do
  use Mix.Project

  def project do
    [
      app: :exvalidate,
      version: "0.0.1",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo,        "~> 1.0.5", only: [:dev, :test], runtime: false},
      {:dialyxir,     "~> 0.5",   only: [:dev, :test], runtime: false},
      {:excoveralls,  "~> 0.11",  only: :test},
      {:jason,        "~> 1.1.2"},
      {:plug,         "~> 1.8.0", optional: true}
    ]
  end
end
