defmodule Exvalidate.Rules.EmailTest do
    use ExUnit.Case
    doctest Exvalidate
  
    alias Exvalidate.Rules.Email
  
    describe "validating/3." do
      test "witha value not supported." do
        rules = :email
        value = nil
  
        result = Email.validating(rules, value)
  
        assert result == {:error, :email_rule_wrong}
      end
  
      test "with value supported and pass validation." do
        rules = :email
        value = "songoku.draognball@gmail.com"
  
        result = Email.validating(rules, value)
  
        assert result == {:ok, "songoku.draognball@gmail.com"}
      end

      test "with value supported and not pass validation" do
        rules = :email
        value = "Son gohan"
  
        result = Email.validating(rules, value)
  
        assert result == {:error, :email_invalid}
      end
    end
  end
  