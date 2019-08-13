defmodule Exvalidate.Rules.Default do
  @moduledoc """

  """

  @spec validating(map, String.t, map) :: {:ok, map}

  def validating(%{"default" => default}, field, data) do
    if Map.has_key?(data, field) do
      {:ok, data}
    else
      {:ok, Map.put_new(data, field, default)}
    end
  end

end
