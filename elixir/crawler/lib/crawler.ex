defmodule Crawler do

  @moduledoc """
    Crawl a web site and print the number of links found on each page.
    Ignores external links.
  """

  alias HTTPotion.Response
  @user_agent [ "User-agent": "zhgeeks crawler demo, mh@noops.co"]


  def main(args) do
    {opts, _, _} = OptionParser.parse(args)
    # IO.inspect args
    {_, uri} = List.keyfind(opts, :uri, 0)
    Tracker.init()
    spawn(Crawler, :process_uris, [uri, self])
    process_results()
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
    if not Tracker.crawled?(uri) do
      Tracker.register(uri)
      case fetch(uri) do
        { :ok, body } ->
          {result, uri_list} = process_page(body)
          results <- { :ok, result }
          uris <- uri_list
        { :error, _ } -> { :error, uri }
      end
    end
  end


  def process_page(_body) do
    { "", [] }
  end


  @doc """
    Fetches the page for the given `uri`.
  """
  def fetch(uri) do
    case HTTPotion.get(uri, @user_agent) do
      Response[body: body, status_code: status, headers: _headers ]
      when status in 200..299 ->
        { :ok, body }
      Response[body: body, status_code: _status, headers: _headers ] ->
        { :error, body }
    end
  end


  @doc """
    Prints the results found by the page crawlers.
  """
  def process_results() do
    receive do
      { :ok, result } -> IO.puts(result)
      { :error, uri } -> IO.puts("no result for #{uri}")
    end
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
