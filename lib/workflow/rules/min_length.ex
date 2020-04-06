defmodule Exvalidate.Rules.MinLength do
  @moduledoc """
  This module validate the length of list and strings. Value types:
  1. String.
  2. Tuple.
  3. List.

  For see examples go to the tests: test/rules/min_length_test.exs  
  """
  use Exvalidate.Rules.IRules

  @type input :: tuple | list | String.t()

  @spec validating({:min_length, number}, input) ::
          {:ok, input}
          | {:error, :min_length_lower_than_min}
          | {:error, :min_length_rule_wrong}
          | {:error, :min_length_value_type_wrong}

  def validating({:min_length, min}, value) when is_integer(min) do
    case is_greater_than(min, value) do
      {:ok, true} ->
        {:ok, value}

      {:ok, false} ->
        {:error, :min_length_lower_than_min}

      # TODO - "#{field} must be greater than or equal to #{min}."

      {:error, msg} ->
        {:error, msg}
    end
  end

  def validating(_, _), do: {:error, :min_length_rule_wrong}
  # TODO - "The rules min_length is wrong."

  defp is_greater_than(min, value) when is_binary(value) do
    {:ok, String.length(value) >= min}
  end

  defp is_greater_than(min, value) when is_list(value) do
    {:ok, Enum.count(value) >= min}
  end

  defp is_greater_than(min, value) when is_tuple(value) do
    {:ok, tuple_size(value) <= min}
  end

  defp is_greater_than(_min, _value) do
    {:error, :min_length_value_type_wrong}
    # TODO - "The field has to be a String or list."
  end
end
