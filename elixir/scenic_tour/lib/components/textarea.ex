# 
# text.ex
# Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
# 
# Distributed under terms of the MIT license.

defmodule ScenicTour.Component.TextArea do
  use Scenic.Component
  alias Scenic.Graph
  import Scenic.Primitives, only: [{:text, 3}, {:update_opts, 2}]

  @graph Graph.build()
         |> text("", text_align: :center, translate: {100, 200}, id: :text)

  def info(data),
    do: """
      #{IO.ANSI.red()}#{__MODULE__} data must be a bitstring
      #{IO.ANSI.yellow()}Received: #{inspect(data)}
      #{IO.ANSI.default_color()}
    """

  def verify(text) when is_bitstring(text), do: {:ok, text}
  def verify(_), do: :invalid_data

  def init(text, opts) do
    # modify the already built graph
    graph =
      @graph
      |> Graph.modify(:_root_, &update_opts(&1, styles: opts[:styles]))
      |> Graph.modify(:text, &text(&1, text, []))

    state = %{
      graph: graph,
      text: text
    }

    {:ok, state, push: graph}
  end

  def textarea(graph, data, options \\ []) do
    __MODULE__.add_to_graph(graph, data, options)
  end
end
