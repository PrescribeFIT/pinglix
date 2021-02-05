defmodule Pinglix.Status do
  defstruct status: "ok",
            now: nil,
            passed: [],
            failures: [],
            timeouts: [],
            http_code: 200,
            checks: []

  def build(checks \\ []) do
    %__MODULE__{checks: checks}
  end

  def set_failed(status, check, message) do
    %__MODULE__{status | status: "failures", failures: status.failures ++ [check], http_code: 503}
    |> Map.put(check, message)
  end

  def set_passed(status, check) do
    %__MODULE__{status | passed: status.passed ++ [check]}
  end

  def set_passed(status, check, message) do
    %__MODULE__{status | passed: status.passed ++ [check]}
    |> Map.put(check, message)
  end

  def set_timed_out(status, check) do
    %__MODULE__{status | status: "failures", timeouts: status.timeouts ++ [check], http_code: 503}
  end

  def set_current_time(status) do
    %__MODULE__{status | now: System.os_time(:second)}
  end

  def to_struct(status) do
    status
    |> Map.delete(:__struct__)
    |> Map.delete(:http_code)
    |> Map.delete(:checks)
    |> Map.delete(:passed)
    |> remove_failures
    |> remove_timeouts
  end

  defp remove_failures(status = %{failures: []}) do
    status
    |> Map.delete(:failures)
  end

  defp remove_failures(status) do
    status
  end

  defp remove_timeouts(status = %{timeouts: []}) do
    status
    |> Map.delete(:timeouts)
  end

  defp remove_timeouts(status) do
    status
  end
end

defimpl Jason.Encoder, for: Pinglix.Status do
  def encode(status, opts) do
    Jason.Encoder.encode(Pinglix.Status.to_struct(status), opts)
  end
end
