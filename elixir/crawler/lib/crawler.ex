defmodule Crawler do

  @moduledoc """
    Crawl a web site and print the number of links found on each page.
    Ignores external links.
  """


  @user_agent [ "User-agent": "zhgeeks crawler demo, mh@noops.co"]


  def main(args) do
    {opts, _, _} = OptionParser.parse(args)
    # IO.inspect args
    {_, uri} = List.keyfind(opts, :uri, 0)
    Tracker.init()
  end


  @doc """
    `:true` if the `uri` was crawled already, `:false` otherwise.
  """
  def crawled?(uri) do
  end


  @doc """
    `:true` if `uri` belongs to `top_level_uri`, `:false` otherwise.
  """
  def external_link?(top_level_uri, uri) do
    String.contains?(uri, top_level_uri)
  end


  @doc """
    Crawls an URI, sends results to the `results` pid and the found URIs
    to the `uris` pid.
  """
  def crawl_uri(uri, results, uris) do
    if not crawled?(uri) do
    end
  end


  @doc """
    Prints the results found by the page crawlers.
  """
  def process_results() do
  end


  @doc """
    Makes sure that all pages are crawled.
  """
  def process_uris(top_level_uri, results_pid) do
    receive do
      uri ->
        if (external_link?(uri, top_level_uri)) do
          spawn(Crawler, :crawl_uri, [uri, results_pid, self])
        end
    end
  end
end
