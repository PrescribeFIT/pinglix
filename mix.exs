defmodule Pinglix.Mixfile do
  use Mix.Project

  def project do
    [
      app: :pinglix,
      description: description(),
      package: package(),
      version: "1.2.0",
      elixir: "~> 1.6",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [extra_applications: [:logger]]
  end

  defp description do
    "Plug compatible health check system in Elixir based on https://github.com/jbarnette/pinglish."
  end

  defp package do
    [
      contributors: ["Paul Van de Vreede"],
      maintainers: ["Paul Van de Vreede"],
      links: %{"Github" => "https://github.com/pvdvreede/pinglix"},
      licenses: ["MIT License"],
      files: ["lib", "mix.exs", "README.md", "LICENSE"]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.23", only: :dev},
      {:jason, "~> 1.2"},
      {:plug, "~> 1.0"}
    ]
  end
end
