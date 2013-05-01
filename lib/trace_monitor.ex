defmodule TraceMonitor do
  use Application.Behaviour

  @doc """
  The application callback used to start this
  application and its Dynamos.
  """
  def start(_type, _args) do
    TraceMonitor.Supervisor.start_link([])
  end
end
