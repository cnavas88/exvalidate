defmodule Exvalidate.Rules.Type do
  @moduledoc false

  @mapping_types %{
    "integer" =>  Exvalidate.Type.Integer,
    "float" =>    Exvalidate.Type.Float,
    "boolean" =>  Exvalidate.Type.Boolean,
    "atom" =>     Exvalidate.Type.Atom,
    "string" =>   Exvalidate.Type.String,
    "list" =>     Exvalidate.Type.List,
    "tuple" =>    Exvalidate.Type.Tuple,
    "map" =>      Exvalidate.Type.Map
  }

  @list_types Map.keys(@mapping_types)

  def validate(%{type: type})
    when type in @list_types do
      {:ok, Map.get(@mapping_types, type)}
  end

  def validate(%{type: type}) do
    {:error, "#{type} is not supported."}
  end

  def validate(%{}) do
    {:error, "The field type is required."}
  end
end
