defmodule Tracker do

  @moduledoc """
    Keeps track of the URIs crawled so far.
  """


  def init(table_name // :uris) do
    case :ets.info(:uris) do
      :undefined -> :ets.new(table_name, [:named_table, :public, {:keypos,1}])
      _ -> :ok
    end
  end


  @doc """
    `:true` if the `uri` was crawled already, `:false` otherwise.
  """
  def crawled?(uri) do
    result = case :ets.lookup(:uris, uri) do
      [] -> :false
      _ -> :true
    end
    IO.puts("?? #{uri} :: #{result}")
    result
  end


  @doc """
    mark/register an URI that was already crawled
  """
  def register(uri) do
    IO.puts("!! #{uri}")
    :ets.insert(:uris, {uri})
  end
end
