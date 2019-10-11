defmodule Exvalidate.Rules.MaxLengthTest do
    use ExUnit.Case
    doctest Exvalidate
  
    alias Exvalidate.Rules.MaxLength
  
    describe "validating/3 max_length is not a number" do
      test "is a string" do
        rules = %{"max_length" => "6"}
        data  = %{"name" => "Vegeta"}
        field = "name"
  
        result = MaxLength.validating(rules, field, data)
  
        assert result == {:error, "The rules max_length is wrong."}          
      end
    end

    describe "validating/3 max_length string." do
      test "string length is lower than maxlength field." do
        rules = %{"max_length" => 20}
        data  = %{"name" => "Vegeta"}
        field = "name"
  
        result = MaxLength.validating(rules, field, data)
  
        assert result == {:ok, %{"name" => "Vegeta"}}
      end
  
      test "string length is equal than maxlength field." do
        rules = %{"max_length" => 3}
        data  = %{"name" => "Boo"}
        field = "name"
  
        result = MaxLength.validating(rules, field, data)
  
        assert result == {:ok, %{"name" => "Boo"}}
      end
  
      test "string validation is wrong." do
        rules = %{"max_length" => 4}
        data  = %{"name" => "Vegeta"}
        field = "name"
  
        result = MaxLength.validating(rules, field, data)
  
        assert result == {:error, "name must be lower than or equal to 4."}
      end
  
      test "The field isn't string or list." do
        rules = %{"max_length" => 2}
        data  = %{"id" => 67}
        field = "id"
  
        result = MaxLength.validating(rules, field, data)
  
        assert result == {:error, "The field has to be a String or list."}
      end
    end
    describe "validating/3 max_length list." do
      test "list length is equal max_length." do
        rules = %{"max_length" => 2}
        data  = %{"name" => ["Vegeta", "Picolo"]}
        field = "name"
  
        result = MaxLength.validating(rules, field, data)
  
        assert result == {:ok, %{"name" => ["Vegeta", "Picolo"]}}
      end
  
      test "list legnth is lower than max length." do
        rules = %{"max_length" => 5}
        data  = %{"name" => ["Vegeta", "Picolo", "Bulma"]}
        field = "name"
  
        result = MaxLength.validating(rules, field, data)
  
        assert result == {:ok, %{"name" => ["Vegeta", "Picolo", "Bulma"]}}
      end
  
      test "list validation is wrong." do
        rules = %{"max_length" => 1}
        data  = %{"name" => ["Vegeta", "Bulma"]}
        field = "name"
  
        result = MaxLength.validating(rules, field, data)
  
        assert result == {:error, "name must be lower than or equal to 1."}
      end
  
      test "The field isn't string or list." do
        rules = %{"max_length" => 2}
        data  = %{"id" => 67}
        field = "id"
  
        result = MaxLength.validating(rules, field, data)
  
        assert result == {:error, "The field has to be a String or list."}
      end
    end
  end
  