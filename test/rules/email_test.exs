defmodule Exvalidate.Rules.EmailTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.Email

  @validate_key :email
  @validate_fn &Email.validating/2

  describe "validating/3." do
    test "with value supported and pass validation." do
      value = "songoku.draognball@gmail.com"

      result = @validate_fn.(@validate_key, value)

      assert result == {:ok, value}
    end
    
    test "witha value not supported." do
      value = nil

      result = @validate_fn.(@validate_key, value)

      assert result == {:error, :email_rule_wrong}
    end

    test "with value supported and not pass validation" do
      value = "Son gohan"

      result = @validate_fn.(@validate_key, value)

      assert result == {:error, :email_invalid}
    end
  end
end
