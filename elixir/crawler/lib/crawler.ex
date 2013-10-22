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
    crawler_pid = spawn(Crawler, :crawl, [uri, self])

    # kick-off the crawling
    munge_1_uri(uri, self, crawler_pid)

    print_results()
  end


  @doc """
    Makes sure that all pages are crawled.
  """
  def crawl(top_level_uri, results_pid) do
    receive do
      uris ->
        Enum.map(uris, fn uri ->
          IO.puts("> #{uri}")
          uri = normalize_uri(top_level_uri, uri)
          IO.puts("+ #{uri}")
          spawn(Crawler, :munge_1_uri, [uri, results_pid, self])
        end)
    end
  end


  @doc """
    Crawls an URI, sends results to the `results` pid and the found URIs
    to the `uris` pid.
  """
  def munge_1_uri(uri, results, uris) do
    IO.puts(">> #{uri}")
    if not Tracker.crawled?(uri) do
      Tracker.register(uri)
      IO.puts(">>> #{uri}")

      case fetch(uri) do
        { :ok, body, headers } ->
          if is_html?(headers) do
            {result, uri_list} = process_page(uri, body)
            results <- { :ok, result }
            uris <- uri_list
          end
        { :error, _, _ } -> { :error, uri }
      end
    end
  end


  @doc """
    Prints the results found by the page crawlers.
  """
  def print_results() do
    receive do
      { :ok, result } -> IO.puts(result)
      { :error, uri } -> IO.puts("no result for #{uri}")
    end
  end


  @doc """
    `:true` if `uri` belongs to `top_level_uri`, `:false` otherwise.
  """
  def internal_link?(top_level_uri, uri) do
    String.contains?(uri, top_level_uri) or String.starts_with?(uri, "/")
  end


  defp is_html?(headers) do
    String.contains?(ListDict.get(headers, :"Content-Type"), "text/html")
  end


  def process_page(uri, body) do
    links = Regex.scan(%r/<a.*href[^=]*=[^"]*"([^"]+)"/gm, body)
    links = Enum.map(links, fn [_, uri] -> uri end)
    { "#{uri} :: #{Enum.count(links)}", links }
  end


  @doc """
    Fetches the page for the given `uri`.
  """
  def fetch(uri) do
    case HTTPotion.get(uri, @user_agent) do
      Response[body: body, status_code: status, headers: headers ]
      when status in 200..299 ->
        { :ok, body,  headers }
      Response[body: body, status_code: _status, headers: headers ] ->
        { :error, body, headers }
    end
  end


  def normalize_uri(top_level_uri, uri) do
    if String.starts_with?(uri, "/") do
      tld = Enum.at(Regex.run(%r{(http[s]?://([^/]+))/}, top_level_uri), 1)
      tld <> uri
    else
      uri
    end
  end
end

