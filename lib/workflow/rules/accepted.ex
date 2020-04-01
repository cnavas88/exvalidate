defmodule Exvalidate.Rules.Accepted do
  @moduledoc """
  The field under validation must be "yes", "on", 1, or true. 

  For see examples go to the tests: test/rules/accepted_test.exs  
  """
  use Exvalidate.Rules.IRules

  @spec validating(:accepted, any) :: 
    {:ok, true} | 
    {:error, :accepted_rule_wrong} |
    {:error, :not_accepted}

  def validating(:accepted, 1), do: {:ok, 1} 

  def validating(:accepted, true), do: {:ok, true}

  def validating(:accepted, value) 
    when is_binary(value) and byte_size(value) > 0 do 
      case String.downcase(value) do
        "yes" ->
          {:ok, value}

        "on" ->
          {:ok, value}

        _ ->
          {:error, :not_accepted}
      end
  end

  def validating(:accepted, _), do: {:error, :not_accepted}

  def validating(_, _), do: {:error, :accepted_rule_wrong}
end
  