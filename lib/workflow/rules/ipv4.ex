defmodule Exvalidate.Rules.IpV4 do
  @moduledoc """
  Validating ip version 4.

  ### Examples
  ```
  iex(3)> Exvalidate.Rules.IpV4.validating(:ipv4, "124.0")
  {:error, :bad_ipv4}
  ```

  ```
  iex(3)> Exvalidate.Rules.IpV4.validating(:ipv4, "124.0.0.1")
  {:ok, "124.0.0.1"}
  ```

  ```
  iex(3)> Exvalidate.Rules.IpV4.validating(:ipv4, 1)
  {:ok, :ipv4_bad_type}
  ```

  For see examples go to the tests: test/rules/ipv4_test.exs  
  """
  use Exvalidate.Rules.IRules

  @regex ~r/^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])/

  def validating(:ipv4, value)
      when is_binary(value) and byte_size(value) > 0 do
    if String.match?(value, @regex) do
      {:ok, value}
    else
      {:error, :bad_ipv4}
    end
  end

  def validating(:ipv4, _), do: {:error, :ipv4_bad_type}
end
