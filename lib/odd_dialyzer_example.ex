defmodule OddDialyzerExample do
  @moduledoc false

  def example(id, opts) when is_list(opts) do
    opts = %{
      foo: Keyword.get(opts, :foo, false),
      bar: Keyword.get(opts, :bar),
      quux: Keyword.get(opts, :quux),
    }

    case id do
      :a ->
        {:ok, example_a(opts)}
      :b ->
        {:ok, example_b(opts)}
      _ ->
        :error
    end
  end


  def example_a(%{foo: false} = opts) do
    "Example A: #{maybe_display_bar(opts)}"
  end

  @spec maybe_display_bar(map()) :: String.t()
  defp maybe_display_bar(%{bar: bar}) when is_binary(bar),
    do: bar

  defp maybe_display_bar(_), do: ""

  def example_b(%{foo: true} = opts) do
    "Example B: #{maybe_display_quux(opts)}"
  end


  @spec maybe_display_quux(map()) :: String.t()
  defp maybe_display_quux(%{quux: quux}) when is_binary(quux),
    do: quux

  defp maybe_display_quux(opts) when is_map(opts), do: ""


  def a do
    foo(:a)
  end

  def b do
    foo(:b)
  end

  @spec foo(:a | :b) :: :also_ok | :ok
  defp foo(:a), do: :ok
  defp foo(bar) when bar in [:b, :c], do: :also_ok
end
