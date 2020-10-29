defmodule Exvalidate.Rules.PasswordTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.Password

  @validate_key :password
  @validate_fn &Password.validating/2

  @custom_regex ~r/^(?=\w*\d)(?=\w*[A-Z])(?=\w*[a-z])\S{8,16}$/

  describe "validating/3 with a exvalidate regex." do

    test "When I want validate a valid password." do
      password = "This_4_p2ssw0rd"

      result = @validate_fn.(@validate_key, password)

      assert result == {:ok, password}
    end

    test "The password is wrong." do
      result = @validate_fn.(@validate_key, true)

      assert result == {:error, :bad_password}
    end

    test "Another the password is wrong." do
      result = @validate_fn.(@validate_key, "this_is_a_password")

      assert result == {:error, :bad_password}
    end

  end

  describe "validating/3 with a custom regex." do

    test "When I want validate a valid password." do
      password = "This4Pass"

      result = @validate_fn.({@validate_key, @custom_regex}, password)

      assert result == {:ok, password}
    end

    test "The password is wrong." do
      result = @validate_fn.({@validate_key, @custom_regex}, true)

      assert result == {:error, :bad_password}
    end

    test "Another the password is wrong." do
      result = @validate_fn.({@validate_key, @custom_regex}, "this_is_a_password")

      assert result == {:error, :bad_password}
    end

  end
end
