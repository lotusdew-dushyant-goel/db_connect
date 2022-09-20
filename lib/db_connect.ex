defmodule DbConnect do
  alias DbConnect.{Repo, Trade}
  require Logger
  @repo Repo

  def list_trades do
    @repo.all()
  end

  def get_trade(id) do
    @repo.get(id)
  end

  def record_trade(data) do
    res =
      %Trade{}
      |> struct(
        data
        |> Map.put(:timestamp, DateTime.utc_now())
      )
      |> @repo.create

    trade_id = Map.fetch!(res, :trade_id)
    {:ok, trade_id}
  end

  def record_trade_status(trade_id, status) do
    @repo.update(trade_id, %{status: status})
    Logger.debug("Updated status #{status} for trade number #{trade_id}")
    {:ok, trade_id}
  end
end

defmodule DbConnect.Mnesia do
  alias Momento

  def boot(nodes \\ [node()]) do
    Memento.stop()
    Memento.Schema.create(nodes)
    Memento.start()
  end

  def setup!(table, nodes \\ [node()]) do
    boot(nodes)
    Memento.Table.create!(table, disc_copies: nodes)
  end
end
