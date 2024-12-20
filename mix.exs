defmodule Ini.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ini,
      description: "Generic INI parse",
      version: "1.0.0",
      elixir: ">= 1.9.2",
      package: package(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
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
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:ex_doc, ">= 0.0.0", only: :dev, runtime: false}]
  end

  def package() do
    %{
      links: %{"Github" => "https://github.com/nathanjohnson320/ini"},
      licenses: ["MIT"]
    }
  end
end
