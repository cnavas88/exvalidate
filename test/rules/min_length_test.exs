defmodule Exvalidate.Rules.MinLengthTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.MinLength

  describe "validating/3 min_length is not a number" do
    test "is a string" do
      rules = %{"min_length" => "6"}
      data  = %{"name" => "Vegeta"}
      field = "name"

      result = MinLength.validating(rules, field, data)

      assert result == {:error, "The rules min_length is wrong."}          
    end
  end

  describe "validating/3 min_length string." do
    test "string length is more than minlength field." do
      rules = %{"min_length" => 2}
      data  = %{"name" => "Vegeta"}
      field = "name"

      result = MinLength.validating(rules, field, data)

      assert result == {:ok, %{"name" => "Vegeta"}}
    end

    test "string length is equal than minlength field." do
      rules = %{"min_length" => 3}
      data  = %{"name" => "Boo"}
      field = "name"

      result = MinLength.validating(rules, field, data)

      assert result == {:ok, %{"name" => "Boo"}}
    end

    test "string validation is wrong." do
      rules = %{"min_length" => 20}
      data  = %{"name" => "Vegeta"}
      field = "name"

      result = MinLength.validating(rules, field, data)

      assert result == {:error, "name must be greater than or equal to 20."}
    end

    test "The field isn't string or list." do
      rules = %{"min_length" => 2}
      data  = %{"id" => 67}
      field = "id"

      result = MinLength.validating(rules, field, data)

      assert result == {:error, "The field has to be a String or list."}
    end
  end
  describe "validating/3 min_length list." do
    test "list length is equal min length." do
      rules = %{"min_length" => 2}
      data  = %{"name" => ["Vegeta", "Picolo"]}
      field = "name"

      result = MinLength.validating(rules, field, data)

      assert result == {:ok, %{"name" => ["Vegeta", "Picolo"]}}
    end

    test "list legnth is more than min length." do
      rules = %{"min_length" => 2}
      data  = %{"name" => ["Vegeta", "Picolo", "Bulma"]}
      field = "name"

      result = MinLength.validating(rules, field, data)

      assert result == {:ok, %{"name" => ["Vegeta", "Picolo", "Bulma"]}}
    end

    test "list validation is wrong." do
      rules = %{"min_length" => 20}
      data  = %{"name" => ["Vegeta"]}
      field = "name"

      result = MinLength.validating(rules, field, data)

      assert result == {:error, "name must be greater than or equal to 20."}
    end

    test "The field isn't string or list." do
      rules = %{"min_length" => 2}
      data  = %{"id" => 67}
      field = "id"

      result = MinLength.validating(rules, field, data)

      assert result == {:error, "The field has to be a String or list."}
    end
  end
end
