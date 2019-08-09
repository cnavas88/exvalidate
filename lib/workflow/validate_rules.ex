defmodule Exvalidate.Validate do
  @moduledoc """

  """
  alias __MODULE__
  alias Exvalidate.Rules.Mapping

  defstruct [:field, :rules, :data]

  def rules(field, rules, data) do
    Enum.reduce_while(rules, %{}, fn rule ->
      case Mapping.
    end)

    {:ok, data}
  end


end
