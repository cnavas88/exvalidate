defmodule Exvalidate.Rules.IRules do
    @moduledoc """
    Interface pattern for the all rules
    """

    @callback validating(map, String.t(), map) :: {:ok, map}
end