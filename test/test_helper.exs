Dynamo.under_test(TraceMonitor.Dynamo)
Dynamo.Loader.enable
ExUnit.start

defmodule TraceMonitor.TestCase do
  use ExUnit.CaseTemplate

  # Enable code reloading on test cases
  setup do
    Dynamo.Loader.enable
    :ok
  end
end
