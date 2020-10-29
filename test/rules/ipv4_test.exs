defmodule Exvalidate.Rules.IpV4Test do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.IpV4

  @validate_key :ipv4
  @validate_fn &IpV4.validating/2

  describe "validating/3." do
    test "When I want validate a valid IP." do
      ip = "127.0.0.1"

      result = @validate_fn.(@validate_key, ip)

      assert result == {:ok, ip}
    end

    test "The data is not accepted." do
      result = @validate_fn.(@validate_key, true)

      assert result == {:error, :ipv4_bad_type}
    end

    test "Validating a bad IP." do
      result = @validate_fn.(@validate_key, "127.0.0.0.1")

      assert result == {:error, :bad_ipv4}
    end
  end
end
