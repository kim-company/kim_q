defmodule Q do
  defstruct [:label, queue: Qex.new(), count: 0]

  def new(label \\ :default), do: %__MODULE__{label: label}

  def push(state = %__MODULE__{queue: queue, count: count, label: label}, item) do
    count = count + 1
    :telemetry.execute([:q], %{count: count}, %{label: label})
    %__MODULE__{state | queue: Qex.push(queue, item), count: count}
  end

  def pop(state = %__MODULE__{queue: queue, count: count, label: label}) do
    case Qex.pop(queue) do
      {{:value, item}, queue} ->
        count = count - 1
        :telemetry.execute([:q], %{count: count}, %{label: label})
        {{:value, item}, %__MODULE__{state | queue: queue, count: count}}

      {:empty, _q} ->
        {:empty, state}
    end
  end

  def pop!(state) do
    case pop(state) do
      {{:value, item}, state} -> {item, state}
      {:empty, _state} -> raise "Queue is empty"
    end
  end

  def take(queue, amount), do: take(queue, amount, [])

  defp take(queue, 0, items) do
    {Enum.reverse(items), queue}
  end

  defp take(queue, n, items) do
    case pop(queue) do
      {{:value, item}, queue} ->
        take(queue, n - 1, [item | items])

      {:empty, queue} ->
        take(queue, 0, items)
    end
  end

  def empty?(%__MODULE__{count: 0}), do: true
  def empty?(_state), do: false
end
