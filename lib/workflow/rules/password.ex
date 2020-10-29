defmodule Exvalidate.Rules.Password do
  @moduledoc """
  We can validate password in two ways:

  1- Our regex that validate: 1 digit, 1 mayus, 1 minus, 1 special character, between 8 and 32.
  2- Developer Regex.

  ### Examples
  ```
  iex(3)> Exvalidate.Rules.Password.validating(:password, "This_4_p2ssw0rd")
  {:ok, "This_4_p2ssw0rd"}
  ```

  ```
  iex(3)> Exvalidate.Rules.Password.validating(:password, "thisApassword")
  {:error, :bad_password}
  ```

  ```
  iex(3)> Exvalidate.Rules.Password.validating(:password, 1)
  {:error, :bad_password}
  ```

  For see examples go to the tests: test/rules/password_test.exs  
  """
  use Exvalidate.Rules.IRules

  @regex ~r/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&#.$($)$-$_])[A-Za-z\d$@$!%*?&#.$($)$-$_]{8,32}$/

  def validating(rule, value)
    when is_binary(value) and byte_size(value) > 0 do
      if is_tuple(rule) do
        {:password, regex} = rule
        match_regex(value, regex)
      else   
        match_regex(value)
      end
  end

  def match_regex(value, regex \\ @regex) do
    if String.match?(value, regex) do
      {:ok, value}
    else
      {:error, :bad_password}
    end      
  end

  def validating(:password, _), do: {:error, :bad_password}
end
