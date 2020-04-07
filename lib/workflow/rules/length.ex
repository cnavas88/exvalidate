defmodule Exvalidate.Rules.Length do
  @moduledoc """
  This rules Specifies the exact length of value, the allowed types are:
  - String: Number of characters allowed.
  - List: exact number of items in the list.
  - Tuple: exact number of items in the tuple.

  For see examples go to the tests: test/rules/length_test.exs
  """
  use Exvalidate.Rules.IRules

  @type input :: tuple | list | String.t()

  @spec validating({:length, number}, input) ::
          {:ok, input}
          | {:error, :length_not_equal}
          | {:error, :length_rule_wrong}
          | {:error, :length_value_type_wrong}

  def validating({:length, length}, value) when is_integer(length) do
    case exact_length(length, value) do
      {:ok, true} ->
        {:ok, value}

      {:ok, false} ->
        {:error, :length_not_equal}

      {:error, msg} ->
        {:error, msg}
    end
  end

  def validating(_, _), do: {:error, :length_rule_wrong}

  defp exact_length(length, value) when is_binary(value) do
    {:ok, String.length(value) == length}
  end

  defp exact_length(length, value) when is_list(value) do
    {:ok, Enum.count(value) == length}
  end

  defp exact_length(length, value) when is_tuple(value) do
    {:ok, tuple_size(value) == length}
  end

  defp exact_length(_length, _value) do
    {:error, :length_value_type_wrong}
  end
end
