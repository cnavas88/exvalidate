defmodule Exvalidate.Rules.Default do
  @moduledoc """
  Validate default rule, this rule validate if exists value.
  If exists value return this value, if not exists return default value.

  ### Examples
  ```
  iex(3)> Exvalidate.Rules.Default.validating({:default, "Son goku"}, nil)
  {:ok, "Son goku"}
  ```

  ```
  iex(3)> Exvalidate.Rules.Default.validating({:default, "Son goku"}, "Son gohan")
  {:ok, "Son gohan"}
  ```

  For see examples go to the tests: test/rules/default_test.exs  
  """
  use Exvalidate.Rules.IRules

  def validating({:default, default}, value)
      when is_nil(value) or byte_size(value) == 0,
      do: {:ok, default}

  def validating({:default, _default}, value), do: {:ok, value}

  def validating(_, _), do: {:error, :default_rule_wrong}
end
