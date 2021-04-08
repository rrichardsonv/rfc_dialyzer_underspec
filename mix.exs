defmodule OddDialyzerExample.MixProject do
  use Mix.Project

  def project do
    [
      app: :odd_dialyzer_example,
      dialyzer: [
        flags: [:unmatched_returns, :error_handling, :underspecs],
        list_unused_filters: true
      ],
      version: "0.1.0",
      elixir: "~> 1.11",
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
    [{:dialyxir, "~> 1.0", runtime: false}]
  end
end
