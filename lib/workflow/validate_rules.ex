defmodule Exvalidate.Validate do
  @moduledoc false
  @route "Elixir.Exvalidate.Rules."

  @spec rules(list, any) :: {:ok, any} | {:error, String.t()}

  @doc false
  def rules(rules, data) do
    Enum.reduce_while(rules, %{}, &filter_rule(&1, &2, data))
  end

  defp filter_rule({key_rule, _value} = rule, _acc, data) do
    case get_module(key_rule) do
      {:ok, module} ->
        execute_module(rule, data, module)

      {:error, msg} ->
        {:halt, {:error, msg}}
    end
  end

  defp filter_rule(rule, _acc, data) do
    case get_module(rule) do
      {:ok, module} ->
        execute_module(rule, data, module)

      {:error, msg} ->
        {:halt, {:error, msg}}
    end
  end

  defp get_module(key) do
    string_key =
      key
      |> Atom.to_string()
      |> Macro.camelize()

    {:ok, String.to_existing_atom(@route <> string_key)}
  rescue
    _ex ->
      {:error, {key, :rule_doesnt_exists}}
  end

  defp execute_module(rule, data, module) do
    case module.validating(rule, data) do
      {:ok, data} ->
        {:cont, {:ok, data}}

      {:error, msg} ->
        {:halt, {:error, {rule, msg}}}
    end
  end
end
