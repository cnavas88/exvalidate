defmodule Exvalidate.Rules.MaxLength do
  @moduledoc """
  This module validate the max length of list and strings. Value types:
  1. String.
  2. Tuple.
  3. List.

  ### Examples string
  ```
  iex(3)> Exvalidate.Rules.MaxLength.validating({:max_length, 3}, "Boo")
  {:ok, "Boo"}
  ```

  ```
  iex(3)> Exvalidate.Rules.MaxLength.validating({:max_length, 1}, "Vegeta")
  {:error, :max_length_greater_than_max}
  ```

  ### Examples list
  ```
  iex(3)> Exvalidate.Rules.MaxLength.validating({:max_length, 2}, ["Vegeta", "Picolo"])
  {:ok, ["Vegeta", "Picolo"]}
  ```

  ```
  iex(3)> Exvalidate.Rules.MaxLength.validating({:max_length, 2}, ["Vegeta", "Picolo", "Bulma"])
  {:error, :max_length_greater_than_max}
  ```

  ### Examples tuple
  ```
  iex(3)> Exvalidate.Rules.MaxLength.validating({:max_length, 3}, {"Vegeta", "Piccolo", "Krilin"})
  {:ok, {"Vegeta", "Piccolo", "Krilin"}}
  ```

  ```
  iex(3)> Exvalidate.Rules.MaxLength.validating({:max_length, 3}, {"Vegeta"})
  {:error, :max_length_greater_than_max}
  ```

  For see examples go to the tests: test/rules/max_length_test.exs  
  """
  use Exvalidate.Rules.IRules

  @type input :: tuple | list | String.t()

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
