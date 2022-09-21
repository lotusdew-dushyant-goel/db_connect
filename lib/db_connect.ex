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
  alias Memento
  require Logger

  def setup!(table) do
    nodes = [node() | Node.list()]
    Logger.info("connected nodes: #{inspect(Node.list())}")

    # Stop Memento on all nodes
    :rpc.multicall(nodes, Memento, :stop, [])
    Logger.debug("memento stop")
    # Create schema on all nodes
    Memento.Schema.create(nodes)
    Logger.debug("memento create scheme")
    # Start Memento on all nodes
    :rpc.multicall(nodes, Memento, :start, [])
    Logger.debug("memento start")
    # Create copies on all node
    Memento.Table.create!(table, disc_copies: nodes)
    Logger.debug("memento create table")
  end
end
