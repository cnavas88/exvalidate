defmodule Exvalidate.Rules.In do
  @moduledoc """
  This module validate that the value or list of values are into the list.
  Types allowed:
  1. String.
  2. Number.
  3. List.

  For see examples go to the tests: test/rules/in_test.exs
  """
  use Exvalidate.Rules.IRules

  @type input :: number | list | String.t()

  @spec validating({:in, list}, input) ::
          {:ok, input}
          | {:error, :in_not_in_list}
          | {:error, :in_rule_wrong}
          | {:error, :in_bad_type_value}

  def validating({:in, list}, value) when is_list(list) do
    case is_in(list, value) do
      {:ok, true} ->
        {:ok, value}

      {:ok, false} ->
        {:error, :in_not_in_list}

      # TODO - "#{field} hasn't into the list."

      {:error, msg} ->
        {:error, msg}
    end
  end

  def validating(_, _), do: {:error, :in_rule_wrong}
  # TODO - "The rule 'in' is wrong."

  defp is_in(list, value) when is_binary(value) or is_number(value) do
    if value in list do
      {:ok, true}
    else
      {:ok, false}
    end
  end

  defp is_in(list, value) when is_list(value) do
    {:ok, Enum.reduce_while(value, %{}, &is_in_list(&1, &2, list))}
  end

  defp is_in(_list, _value) do
    {:error, :in_bad_type_value}
    # TODO - "The field has to be a String, number or list."
  end

  defp is_in_list(opt, _acc, list) do
    if opt in list do
      {:cont, true}
    else
      {:halt, false}
    end
  end
end
