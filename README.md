# hometime

## ERD

![hometime](https://github.com/user-attachments/assets/9a333a2f-5e6b-40b6-a407-3752727bce11)

## Attribute 

### Guest

| Attribute   | Data type | Definition |
|-------------|-----------|------------|
| email       | string    | Guest’s unique email address. Required. |
| first_name  | string    | Guest’s given name. Required. |
| last_name   | string    | Guest’s family name. Required. |
| phone       | string    | Guest’s contact number. Required. |
| created_at  | datetime  | Record creation timestamp. |
| updated_at  | datetime  | Last update timestamp. |

### Reservation 

| Attribute      | Data type | Definition |
|----------------|-----------|------------|
| id             | integer   | Unique ID. |
| adults         | integer   | Number of adult guests. Required, must be at least 1. |
| children       | integer   | Number of child guests. Optional. |
| currency       | string    | Currency code for the price amount. Required |
| guest_count    | integer   | Total number of guests (adults + children + infants). Required |
| guest_id       | integer   | Foreign key referencing the guest. Required. |
| infants        | integer   | Number of infant guests. Optional.  |
| nights         | integer   | Total nights between start and end date. Required |
| payout_price   | decimal   | Host/platform payout amount. Required |
| security_price | decimal   | Security or deposit amount. Required |
| status         | string    | Reservation status (must be in allowed list of statuses). Required |
| total_price    | decimal   | Total amount paid by the guest. Required |
| created_at     | datetime  | Timestamp when reservation was created. |
| start_date     | date      | Check-in date. Required. |
| end_date       | date      | Check-out date. Required. |
| updated_at     | datetime  | Timestamp when reservation was last updated. |
