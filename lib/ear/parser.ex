defmodule Ear.Parser do
  @moduledoc ~S"""
  Implements version 1.5.* of the Parser
  """
  alias Ear.{Options, Parsers, Peg, State}

  def parse(lines, options \\ struct(Options)) do
    lines
    |> State.new(options)
    |> _parse
    |> State.result
  end

  defp _parse(state)

  defp _parse(%{token: nil} = state) do
    state
  end

  defp _parse(state) do
    case _parsers.(state) do
      # Change :ok in result depending on state.messages
      {:ok, state_} -> _parse(state_ |> IO.inspect())
      {:error, messages} -> {:error, Enum.sort(messages)}
    end
  end

  defp _parsers do
    Peg.sequence([&Parsers.TextParser.parse/1, &Parsers.IllegalTokenParser.parse/1])
  end
end

# SPDX-License-Identifier: Apache-2.0
