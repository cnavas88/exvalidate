defmodule Exvalidate.Rules.Between do
    @moduledoc """
    The field under validation must have a size between the given min and max. 
    - Strings: length is between those values.
    - Numerics: value is between those values.
    - Arrays: length of array is between those values.
  
    For see examples go to the tests: test/rules/between_test.exs  
    """
    use Exvalidate.Rules.IRules
  
    @spec validating({:between, {number, number}}, any) :: 
      {:ok, true} | 
      {:error, :between_rule_wrong}
  
    def validating({:between, {min, max}}, value), do: {:ok, value} 
  
    def validating(_, _), do: {:error, :between_rule_wrong}
  end
    