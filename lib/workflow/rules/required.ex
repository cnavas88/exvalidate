defmodule Exvalidate.Rules.Required do
  @moduledoc """
  Required rule check the data content, if the content is nil or empty string 
  the rule required return error.

  For see examples go to the tests: test/rules/required_test.exs
  """
  use Exvalidate.Rules.IRules

  def validating(:required, value)
      when is_nil(value) or byte_size(value) == 0,
      do: {:error, :required_value_wrong}

  def validating(:required, value), do: {:ok, value}

  def validating(_, _), do: {:error, :required_rule_wrong}
end
