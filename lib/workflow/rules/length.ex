defmodule Exvalidate.Rules.Length do
  @moduledoc """
  This rules Specifies the exact length of value, the allowed types are:
  - String: Number of characters allowed.
  - List: exact number of items in the list.
  - Tuple: exact number of items in the tuple.
  """
  use Exvalidate.Rules.IRules

  @type value_types :: tuple | list | String.t

  @spec validating({:length, number}, value_types) :: 
    {:ok, value_types} |
    {:error, :length_not_equal} |
    {:error, :rule_length_not_integer}

  def validating({:length, length}, value) when is_integer(length) do
    case exact_length(length, value) do
      {:ok, true} ->
        {:ok, value}

      {:ok, false} ->
        {:error, :length_not_equal} # "#{field} must be equal than #{length}."

      {:error, msg} ->
        {:error, msg}
    end
  end

  def validating(_, _), do: {:error, :rule_length_not_integer}

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
    {:error, :length_value_type_wrong} # "The field has to be a String or list."
  end
end
