defmodule DbConnect.Repo do
  alias DbConnect.Trade

  def create(%Trade{} = trade) do
    Memento.transaction!(fn ->
      Memento.Query.write(trade)
    end)
  end

  def all do
    Memento.transaction!(fn ->
      Memento.Query.all(Trade)
    end)
  end

  def get(id) do
    Memento.transaction!(fn ->
      Memento.Query.read(Trade, id)
    end)
  end

  def get_query(guards) do
    Memento.transaction!(fn ->
      Memento.Query.select(Trade, guards)
    end)
  end

  def delete(id) do
    Memento.transaction!(fn ->
      Memento.Query.delete(Trade, id)
    end)
  end

  def delete_record(%Trade{} = trade) do
    Memento.transaction!(fn ->
      Memento.Query.delete_record(trade)
    end)
  end

  def update(id, %{} = changes) do
    Memento.transaction(fn ->
      case Memento.Query.read(Trade, id, lock: :write) do
        %Trade{} = trade ->
          trade
          |> struct(changes)
          |> Memento.Query.write()
          |> then(&{:ok, &1})

        nil ->
          {:error, :not_found}
      end
    end)
  end
end
