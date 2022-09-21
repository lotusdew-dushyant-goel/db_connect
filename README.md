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
    :user_id => 5,
    :symbol => "INFY",
    :price => 3000_00,
    :quantity => 20,
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
Find trade with id 7.