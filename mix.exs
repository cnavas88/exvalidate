defmodule Exvalidate.MixProject do
  use Mix.Project

  @test_envs [:unit, :integration]

  def project do
    [
      app: :exvalidate,
      version: "0.0.1",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      # elixirc_options: [warnings_as_errors: true],
      elixirc_paths: elixirc_paths(Mix.env()),
      est_paths: test_paths(Mix.env()),
      description: description(),
      package: package(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],

      # Docs
      source_url: "https://github.com/cnavas88/exvalidate",
      homepage_url: "https://github.com/cnavas88/exvalidate"
    ]
  end

  defp description do
    "exvalidate is a data validator for elixir, container a plug for the
    validate request."
  end

  defp package do
    [
      maintainers: ["Carlos Navas"],
      licenses: [],
      links: %{
        "Github" => "https://github.com/cnavas88/exvalidate"
      }
    ]
  end

  defp elixirc_paths(env) when env in @test_envs, do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp aliases do
    [
      "test.all": ["test.unit", "test.integration"],
      "test.unit": &run_unit_tests/1,
      "test.integration": &run_integration_tests/1,
      quality: ["format", "credo --strict", "dialyzer"],
      "quality.ci": [
        "format --check-formatted",
        "credo --strict",
        "dialyzer --halt-exit-status"
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger, :plug]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.0.5", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.11", only: :test},
      {:jason, "~> 1.1.2"},
      {:plug, "~> 1.8.0", optional: true}
    ]
  end

  defp test_paths(:integration), do: ["test/integration"]
  defp test_paths(:unit), do: ["test/unit"]
  defp test_paths(_), do: ["test/unit", "test/integration"]

  defp run_integration_tests(args), do: test_with_env("integration", args)
  defp run_unit_tests(args), do: test_with_env("unit", args)

  defp test_with_env(env, args) do
    args = if IO.ANSI.enabled?, do: ["--color"|args], else: ["--no-color"|args]
    
    IO.puts "==> Running tests with `MIX_ENV=#{env}`"
    {_, res} = System.cmd "mix", ["test"|args],
      into: IO.binstream(:stdio, :line),
      env: [{"MIX_ENV", to_string(env)}]
  
    if res > 0 do
      System.at_exit(fn _ -> exit({:shutdown, 1}) end)
    end
  end
end
