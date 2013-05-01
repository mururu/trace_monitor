defmodule TraceMonitor.EventServer do
  use GenServer.Behaviour

  def start_link do
    :gen_server.start_link({ :local, __MODULE__ }, __MODULE__, [], [])
  end

  def add(pid, type, contents, time) do
    :gen_server.cast(__MODULE__, { :add, pid, type, contents, time })
  end

  def all do
    :gen_server.call(__MODULE__, :all)
  end

  def init(_) do
    { :ok, [] }
  end

  def handle_cast({ :add, pid, type, contents, time }, list) do
    { :noreply, [[pid: pid, type: type, contents: contents, time: time]|list] }
  end

  def handle_call(:all, _from, list) do
    { :reply, list, list }
  end
end
