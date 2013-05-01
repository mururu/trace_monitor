defmodule TraceMonitor.Supervisor do
  use Supervisor.Behaviour

  def start_link(arg) do
    :supervisor.start_link(__MODULE__, arg)
  end


  def init(_) do
    children = [
      worker(TraceMonitor.EventServer, []),
      supervisor(TraceMonitor.Dynamo, [])
    ]
    supervise children, strategy: :one_for_one
  end
end
