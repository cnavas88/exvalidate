defmodule Exvalidate.Rules.LengthTest do
    use ExUnit.Case
    doctest Exvalidate
  
    alias Exvalidate.Rules.Length
  
    describe "validating/3 length is not a number" do
      test "is a string" do
        rules = %{"length" => "6"}
        data = %{"name" => "Vegeta"}
        field = "name"
  
        result = Length.validating(rules, field, data)
  
        assert result == {:error, "The rule length is wrong."}
      end
    end
  
    describe "validating/3 length." do
      test "list length is equal than length." do
        rules = %{"length" => 2}
        data = %{"name" => ["Vegeta", "Picolo"]}
        field = "name"
  
        result = Length.validating(rules, field, data)
  
        assert result == {:ok, %{"name" => ["Vegeta", "Picolo"]}}
      end
  
      test "list length is not equal than length." do
        rules = %{"length" => 5}
        data = %{"name" => ["Vegeta", "Picolo", "Bulma"]}
        field = "name"
  
        result = Length.validating(rules, field, data)
  
        assert result == {:error, "name must be equal than 5."}
      end
  
      test "string validation is not equal than length." do
        rules = %{"length" => 1}
        data = %{"name" => "Vegeta"}
        field = "name"
  
        result = Length.validating(rules, field, data)
  
        assert result == {:error, "name must be equal than 1."}
      end
  
      test "string validation is equal than length." do
        rules = %{"length" => 6}
        data = %{"name" => "Vegeta"}
        field = "name"
  
        result = Length.validating(rules, field, data)
  
        assert result == {:ok, %{"name" => "Vegeta"}}
      end

      test "Value is not a string or list." do
        rules = %{"length" => 6}
        data = %{"id" => 6}
        field = "id"
  
        result = Length.validating(rules, field, data)
  
        assert result == {:error, "The field has to be a String or list."}
      end
    end
  end
  