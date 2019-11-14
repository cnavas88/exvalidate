defmodule Exvalidate.Rules.Default do
  @moduledoc """
  Validate default rule, this rule find the value into the map, if search this
  value return de map, if doesn't find this value, adding it to the map.
  """
  @behaviour Exvalidate.Rules.IRules

  @spec validating(map, String.t(), map) :: {:ok, map}

  def validating(%{"default" => default}, field, data) do
    if Map.has_key?(data, field) do
      {:ok, data}
    else
      {:ok, Map.put_new(data, field, default)}
    end
  end
end
