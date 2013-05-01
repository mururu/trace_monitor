defmodule TraceMonitor.Mixfile do
  use Mix.Project

  def project do
    [ app: :trace_monitor,
      version: "0.0.1",
      dynamos: [TraceMonitor.Dynamo],
      compilers: [:elixir, :dynamo, :app],
      env: [prod: [compile_path: "ebin"]],
      compile_path: "tmp/#{Mix.env}/trace_monitor/ebin",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [ applications: [:cowboy, :dynamo],
      mod: { TraceMonitor, [] } ]
  end

  defp deps do
    [ { :ranch, %r(.*), github: "extend/ranch" },
      { :cowboy, %r(.*), github: "extend/cowboy" },
      { :dynamo, "0.1.0.dev", github: "elixir-lang/dynamo" },
      { :exdatetime, nil, github: "mururu/exdatetime" }]
  end
end
