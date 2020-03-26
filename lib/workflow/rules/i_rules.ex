defmodule Exvalidate.Rules.IRules do
  @moduledoc """
  Interface pattern for the all rules
  """

  @callback validating(tuple | atom, any) :: {:ok, map}

  defmacro __using__(_) do
    quote do
      alias Exvalidate.Rules.IRules

      @behaviour IRules

      @impl IRules
      def validating(_, _) do
        raise "validating/2 Not implemented."
      end

      defoverridable [validating: 2]
    end
  end
end