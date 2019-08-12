defmodule Exvalidate.Validate do
  @moduledoc """

  """
  alias __MODULE__
  alias Exvalidate.Rules.Mapping

  def rules(field, rules, data) do
    Enum.reduce_while(rules, %{}, fn {key, value}, acc ->
      case Mapping.get_module(key) do
        {:ok, module} ->
          execute_module(rules, field, data, module)

        {:error, msg} ->
          {:halt, {:error, msg}}
      end
    end)
  end

  defp execute_module(rules, field, data, module) do
    case module.validating(rules, field, data) do
      {:ok, data} ->
        {:cont, {:ok, data}}

      {:error, msg} ->
        {:halt, {:error, msg}}
    end
  end

end