# DbConnect

**Description**

This app will run on multiple nodes, to test table consistency.  

---

**Setup**

1.

```
  DbConnect.Mnesia.setup!(DbConnect.Trade)
```
Sets up the table.

2. 
```
  DbConnect.record_trade(%{
    :user_id => 7,
    :symbol => "TCS",
    :price => 1200_00,
    :quantity => 4200,
    :order_type => "B"
  })
```
Inserts a record.

3.
```
DbConnect.list_trades()
```
Lists all records.

4. 
```
DbConnect.get_trade(7)
```
