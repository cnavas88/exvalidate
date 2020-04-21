defmodule Exvalidate.Rules.Between do
  @moduledoc """
  The field under validation must have a size between the given min and max. 
  - Strings: length is between those values.
  - Numerics: value is between those values.
  - Lists: length of array is between those values.
  - Tuple: length of tuple is between those values.

  ### Examples with string
  ```
  iex(3)> Exvalidate.Rules.Between.validating({:between, {"6", "10"}}, "Vegeta")
  {:error, :between_rule_wrong}
  ```

  ```
  iex(3)> Exvalidate.Rules.Between.validating({:between, {4, 20}}, "Vegeta")
  {:ok, "Vegeta"}
  ```

  ### Examples with numerics
  ```
  iex(3)> Exvalidate.Rules.Between.validating({:between, {4, 20}}, 7)
  {:ok, 7}
  ```

  ```
  iex(3)> Exvalidate.Rules.Between.validating({:between, {4, 20}}, 35)
  {:error, :not_between_min_max}
  ```

  ### Examples with lists
  ```
  iex(3)> Exvalidate.Rules.Between.validating({:between, {4, 20}}, ["Vegeta", "Goku", "Picolo", "Krilin"])
  {:ok, ["Vegeta", "Goku", "Picolo", "Krilin"]}
  ```

  ```
  iex(3)> Exvalidate.Rules.Between.validating({:between, {3, 5}}, ["Vegeta", "Krilin"])
  {:error, :not_between_min_max}
  ```

  ### Examples with tuple
  ```
  iex(3)> Exvalidate.Rules.Between.validating({:between, {4, 20}}, {"Vegeta", "Goku", "Picolo", "Krilin"})
  {:ok, {"Vegeta", "Goku", "Picolo", "Krilin"}}
  ```

  ```
  iex(3)> Exvalidate.Rules.Between.validating({:between, {4, 20}}, {"Vegeta", "Krilin"})
  {:error, :not_between_min_max}
  ```

  For see examples go to the tests: test/rules/between_test.exs  
  """
  use Exvalidate.Rules.IRules

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

  def validating(_, _), do: {:error, :between_rule_wrong}

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
end
