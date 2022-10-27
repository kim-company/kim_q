defmodule Q.MixProject do
  use Mix.Project

  def project do
    [
      app: :kim_q,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:qex, "~> 0.5"},
      {:telemetry, "~> 1.1"},
      {:vega_lite, "~> 0.1.6", optional: true}
    ]
  end
end
