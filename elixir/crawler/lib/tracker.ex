defmodule Tracker do

  @moduledoc """
    Keeps track of the URIs crawled so far.
  """


  def init(table_name // :uris) do
    case :ets.info(:uris) do
      :undefined -> :ets.new(table_name, [:named_table, {:keypos,1}])
      _ -> :ok
    end
  end


  @doc """
    `:true` if the `uri` was crawled already, `:false` otherwise.
  """
  def crawled?(uri) do
    case :ets.lookup(:uris, uri) do
      [] -> :false
      _ -> :true
    end
  end


  @doc """
    mark/register an URI that was already crawled
  """
  def register(uri) do
    :ets.insert(:uris, {uri})
  end
end
