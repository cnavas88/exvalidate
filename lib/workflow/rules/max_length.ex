defmodule Exvalidate.Rules.MaxLength do
  @moduledoc """
  This module validate the length of list and strings. Value types:
  1. String.
  2. Tuple.
  3. List.

  For see examples go to the tests: test/rules/max_length_test.exs  
  """
  use Exvalidate.Rules.IRules

  @type input :: tuple | list | String.t()

  @spec validating({:max_length, number}, input) ::
          {:ok, input}
          | {:error, :max_length_greater_than_max}
          | {:error, :max_length_rule_wrong}
          | {:error, :max_length_value_type_wrong}

  def validating({:max_length, max}, value) when is_integer(max) do
    case is_lower_than(max, value) do
      {:ok, true} ->
        {:ok, value}

      {:ok, false} ->
        {:error, :max_length_greater_than_max}

      {:error, msg} ->
        {:error, msg}
    end
  end

  def validating(_, _), do: {:error, :max_length_rule_wrong}
  # TODO - "The rules max_length is wrong."

  defp is_lower_than(max, value) when is_binary(value) do
    {:ok, String.length(value) <= max}
  end

  defp is_lower_than(max, value) when is_list(value) do
    {:ok, Enum.count(value) <= max}
  end

  defp is_lower_than(max, value) when is_tuple(value) do
    {:ok, tuple_size(value) <= max}
  end

  defp is_lower_than(_max, _value) do
    {:error, :max_length_value_type_wrong}
  end
end
