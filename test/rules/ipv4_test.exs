defmodule Exvalidate.Rules.IpV4Test do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.IpV4

  describe "validating/3." do
    test "When I want validate a valid IP." do
      ip = "127.0.0.1"

      result = IpV4.validating(:ipv4, ip)

      assert result == {:ok, ip}
    end

    test "The data is not accepted." do
      result = IpV4.validating(:ipv4, true)

      assert result == {:error, :ipv4_bad_type}
    end

    test "Validating a bad IP." do
      result = IpV4.validating(:ipv4, "127.0.0.0.1")

      assert result == {:error, :bad_ipv4}      
    end
  end
end
