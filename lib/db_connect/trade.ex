defmodule DbConnect.Trade do
  alias Memento

  use Memento.Table,
    attributes: [
      :trade_id,
      :user_id,
      :symbol,
      :price,
      :quantity,
      :order_type,
      :timestamp,
      :status
    ],
    type: :ordered_set,
    autoincrement: true
end
