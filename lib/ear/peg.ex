defmodule Ear.Peg do
  @moduledoc ~S"""
  A simple peg parser for parsers of a very specific shape

  Each parser takes an `Ear.State` and returns either `{:ok, Ear.State}` or `{:error, MapSet of messages}`
  """

  def sequence(parsers), do: &_sequence(parsers, &1, MapSet.new())
  defp _sequence(parsers, state, errors)
  defp _sequence([], _state, errors), do: {:error, errors}

  defp _sequence([parser|rest], state, errors) do
    case parser.(state) do
      new_state = {:ok, _} -> new_state
      {:error, messages} ->
        _sequence(rest, state, MapSet.union(errors, messages))
    end
  end

end
#  SPDX-License-Identifier: Apache-2.0
