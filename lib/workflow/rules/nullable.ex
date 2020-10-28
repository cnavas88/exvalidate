defmodule Exvalidate.Rules.Nullable do
  @moduledoc """
  The field have to be nil or "". 

  ### Examples
  ```
  iex(3)> Exvalidate.Rules.Nullable.validating(:nullable, nil)
  {:ok, nil}
  ```

  ```
  iex(3)> Exvalidate.Rules.Nullable.validating(:nullable, "")
  {:ok, ""}
  ```

  ```
  iex(3)> Exvalidate.Rules.Nullable.validating(:nullable, "picolo")
  {:error, :not_nullable}
  ```

  ```
  iex(3)> Exvalidate.Rules.Nullable.validating(:nullable, 23)
  {:error, :not_nullable}
  ```

  ```
  iex(3)> Exvalidate.Rules.Nullable.validating(:nullablle, 23)
  {:error, :nullable_rule_wrong}
  ```

  For see examples go to the tests: test/rules/nullable_test.exs  
  """
  use Exvalidate.Rules.IRules

  def validating(:nullable, ""), do: {:ok, ""}

  def validating(:nullable, nil), do: {:ok, nil}

  def validating(:nullable, _), do: {:error, :not_nullable}

  def validating(_, _), do: {:error, :nullable_rule_wrong}
end
