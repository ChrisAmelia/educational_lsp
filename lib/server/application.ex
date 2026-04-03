defmodule EducationalLSP.Application do
  use Application

  @impl true
  def start(_start_type, _start_args) do
    children = [EducationalLSP.InputServer]

    opts = [strategy: :one_for_one, name: EducationalLSP.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
