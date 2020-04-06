defmodule Exvalidate.Rules.Between do
  @moduledoc """
  The field under validation must have a size between the given min and max. 
  - Strings: length is between those values.
  - Numerics: value is between those values.
  - Arrays: length of array is between those values.
  - Tuple: length of tuple is between those values.

  For see examples go to the tests: test/rules/between_test.exs  
  """
  use Exvalidate.Rules.IRules

  @spec validating({:between, {number, number}}, any) ::
          {:ok, String.t() | number | tuple | list}
          | {:error, :between_rule_wrong}
          | {:error, :between_value_invalid}
          | {:error, :not_between_min_max}

  def validating({:between, {min, max}}, value)
      when is_number(min) and is_number(max) do
    case is_between(min, max, value) do
      {:ok, true} ->
        {:ok, value}

      {:ok, false} ->
        {:error, :not_between_min_max}

      error ->
        error
    end
  end

  defp is_between(min, max, value)
       when is_number(value) do
    {:ok, value >= min and value <= max}
  end

  defp is_between(min, max, value)
       when is_binary(value) and byte_size(value) > 0 do
    {:ok, String.length(value) >= min and String.length(value) <= max}
  end

  defp is_between(min, max, value)
       when is_list(value) do
    {:ok, Enum.count(value) >= min and Enum.count(value) <= max}
  end

  defp is_between(min, max, value)
       when is_tuple(value) do
    {:ok, tuple_size(value) >= min and tuple_size(value) <= max}
  end

  defp is_between(_, _, _), do: {:error, :between_value_invalid}

  def validating(_, _), do: {:error, :between_rule_wrong}
end
