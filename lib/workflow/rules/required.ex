defmodule Exvalidate.Rules.Required do
  @moduledoc """
  Required rule check the data content, if the content is nil or empty string 
  the rule required return error.

  ### Examples
  ```
  iex(3)> Exvalidate.Rules.Required.validating(:required, 1234)
  {:ok, 1234}
  ```

  ```
  iex(3)> Exvalidate.Rules.Required.validating(:required, "")
  {:error, :required_value_wrong}
  ```

  ```
  iex(3)> Exvalidate.Rules.Required.validating(:required, nil)
  {:error, :required_value_wrong}
  ```

  For see examples go to the tests: test/rules/required_test.exs
  """
  use Exvalidate.Rules.IRules

  def validating(:required, value)
      when is_nil(value) or byte_size(value) == 0,
      do: {:error, :required_value_wrong}

  def validating(:required, value), do: {:ok, value}

  def validating(_, _), do: {:error, :required_rule_wrong}
end
