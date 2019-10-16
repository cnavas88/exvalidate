defmodule Exvalidate.Validate do
  @moduledoc """
  This module validate the data map with the schema map structure.
  contains the error control module for the rules.
  """
  @route "Elixir.Exvalidate.Rules."

  @spec rules(String.t(), map, map) :: {:ok, map} | {:error, String.t()}

  @doc """
  This is the mean function, this function go through the rules, generate
  the module and execute this module if exists, if doesn't exists return error
  with a message.

  Parameters:
  - field: is a enter parameter to check.
  - rules: map with the rules assign to field element to check.
  - data: map with the all validate data.
  """
  def rules(field, rules, data) do
    Enum.reduce_while(rules, %{}, fn {key, _value}, _acc ->
      case get_module(key) do
        {:ok, module} ->
          execute_module(rules, field, data, module)

        {:error, msg} ->
          {:halt, {:error, msg}}
      end
    end)
  end

  @spec get_module(String.t()) :: {:ok, module} | {:error, String.t()}

  defp get_module(key) do
    {:ok, String.to_existing_atom(@route <> Macro.camelize(key))}
  rescue
    _ex ->
      {:error, "The rule '#{key}' doesn't exists."}
  end

  @spec execute_module(map, String.t(), map, atom) ::
          {:cont, {:ok, map}} | {:halt, {:error, String.t()}}

  defp execute_module(rules, field, data, module) do
    case module.validating(rules, field, data) do
      {:ok, data} ->
        {:cont, {:ok, data}}

      {:error, msg} ->
        {:halt, {:error, msg}}
    end
  end
end
