defmodule Ear.Ast do
  @moduledoc false


  def add_quad_to_content({pt, pa, pc, pm}, tag, content, atts \\ []) do
    {pt, pa, [make_quad(tag, content, atts)|pc], pm}
  end

  def add_text_to_content({pt, pa, pc, pm}, text) do
    {pt, pa, [text|pc], pm}
  end

  def make_quad(tag, content, atts \\ [])
  def make_quad(tag, content, atts) when is_list(content) do
    {atts_, meta_} = _extract_meta(atts)
    {tag, atts_, content, meta_}
  end
  def make_quad(tag, content, atts), do: make_quad(tag, [content], atts)

  defp _extract_meta(atts) do
    atts_ = atts |> Enum.into(%{})
    meta_ = Map.get(atts_, :meta, %{})
    {Map.delete(atts_, :meta), meta_}
  end
end
