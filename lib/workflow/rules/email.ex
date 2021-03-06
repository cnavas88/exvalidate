defmodule Exvalidate.Rules.Email do
  @moduledoc """
  Validate email rule, return ok if email is valid, an error if is invalid.

  ### Examples
  ```
  iex(3)> Exvalidate.Rules.Email.validating(:email, "songoku.dragonball@gmail.com")
  {:ok, "songoku.dragonball@gmail.com"}
  ```

  ```
  iex(3)> Exvalidate.Rules.Email.validating(:email, "Son gohan")
  {:error, :email_invalid}
  ```

  For see examples go to the tests: test/rules/email_test.exs  
  """
  use Exvalidate.Rules.IRules

  @regex ~r/^[A-Za-z0-9._%+-+']+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/

  def validating(:email, email) when is_binary(email) do
    case Regex.run(@regex, email) do
      nil ->
        {:error, :email_invalid}

      [email_filtred] ->
        {:ok, email_filtred}
    end
  end

  def validating(_, _), do: {:error, :email_rule_wrong}
end
