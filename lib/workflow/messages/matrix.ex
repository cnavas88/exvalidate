defmodule Exvalidate.Messages.Matrix do
  @moduledoc """
  Matrix contains the all messages for errors.
  """

  @matrix %{
    :required_rule_wrong => "The rule required is wrong.",
    :required_value_wrong => "The value '%VALUE%' is required."
  }

  def get_message(a_message, value) do
    message = Map.get(@matrix, a_message)
    String.replace(message, "'%VALUE%'", value)
  end 
end