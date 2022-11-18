defmodule Q.MixProject do
  use Mix.Project

  @version "1.0.0"
  @link "https://github.com/kim-company/kim_q"

  def project do
    [
      app: :kim_q,
      version: @version,
      source_url: @link,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
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

  defp package do
    [
      maintainers: ["KIM Keep In Mind"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @link}
    ]
  end
end
