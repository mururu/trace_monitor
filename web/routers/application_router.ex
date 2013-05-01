defmodule ApplicationRouter do
  use Dynamo.Router

  prepare do
    # Pick which parts of the request you want to fetch
    # You can comment the line below if you don't need
    # any of them or move them to a forwarded router
    conn.fetch([:cookies, :params])
  end

  # It is common to break your Dynamo in many
  # routers forwarding the requests between them
  # forward "/posts", to: PostsRouter


  get "/register" do
    type = conn.params[:type]
    pid  = conn.params[:pid]
    contents  = conn.params[:contents]
    time = ts_to_datetime(conn.params[:ts])
    TraceMonitor.EventServer.add(pid, type, contents, time)
    conn.send(200, "ok")
  end

  get "/" do
    events = TraceMonitor.EventServer.all
    conn = conn.assign(:events, events)
    render conn, "index.html"
  end

  def ts_to_datetime(ts) do
    [_, megasec, sec, microsec ] = Regex.run(%r/{(\d+),(\d+),(\d+)}/, ts)
    DateTime.from_timestamp({binary_to_integer(megasec), binary_to_integer(sec), binary_to_integer(microsec)})
  end
end
