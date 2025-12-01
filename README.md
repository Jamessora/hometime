# Hometime Assessment

### Ruby Version

- Ruby 3.3.9

### Rails Version

- Rails 8.0.4

### Prerequisite

Docker - used for PostgreSQL

## Setup 

### Clone Git Repository

```
git clone https://github.com/Jamessora/hometimetest.git
cd hometimetest
```

### Run a local Postgres 16 using Docker

```
docker run --name hometimetest-postgres \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_DB=hometimetest_development \
  -p 5432:5432 \
  -d postgres:16
```

```
docker start hometimetest-postgres
```

### Install dependencies

```
bundle install
```

### Prepare database

To create and migrate for development and test database:

```
bin/rails db:prepare
```

### Run the App

```
bin/rails s
```
App will be available at http://localhost:3000

### Run Tests

```
bundle exec rspec
```
Simplecov generates a coverage report in `coverage/` directory

## ERD

![hometime](https://github.com/user-attachments/assets/9a333a2f-5e6b-40b6-a407-3752727bce11)

## Attribute 

### Guest

| Attribute   | Data type | Definition |
|-------------|-----------|------------|
| email       | string    | Guest’s unique email address. Required. |
| first_name  | string    | Guest’s given name. Required. |
| last_name   | string    | Guest’s family name. Required. |
| phone_numbers| text      | List of contact numbers. Required. |
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


## Endpoint

```
POST /reservations
```

## Supported Payload formats

### Format 1
```
{
  "start_date": "2021-03-12",
  "end_date": "2021-03-16",
  "nights": 4,
  "guests": 4,
  "adults": 2,
  "children": 2,
  "infants": 0,
  "status": "accepted",
  "guest": {
    "id": 1,
    "first_name": "Wayne",
    "last_name": "Woodbridge",
    "phone": "639123456789",
    "email": "wayne_woodbridge@bnb.com"
  },
  "currency": "AUD",
  "payout_price": "3800.00",
  "security_price": "500",
  "total_price": "4500.00"
}
```

### Format 2
```
{
  "reservation": {
    "start_date": "2021-03-12",
    "end_date": "2021-03-16",
    "expected_payout_amount": "3800.00",
    "guest_details": {
      "localized_description": "4 guests",
      "number_of_adults": 2,
      "number_of_children": 2,
      "number_of_infants": 0
    },
    "guest_email": "wayne_woodbridge@bnb.com",
    "guest_first_name": "Wayne",
    "guest_id": 1,
    "guest_last_name": "Woodbridge",
    "guest_phone_numbers": [
      "639123456789",
      "639123456789"
    ],
    "listing_security_price_accurate": "500.00",
    "host_currency": "AUD",
    "nights": 4,
    "number_of_guests": 4,
    "status_type": "accepted",
    "total_paid_amount_accurate": "4500.00"
  }
}
```

## Responses

### Successful
```
{
    "data": {
        "id": "1",
        "type": "reservation",
        "attributes": {
            "adults": 2,
            "children": 2,
            "currency": "AUD",
            "guest_count": 4,
            "guest_id": 1,
            "infants": 0,
            "nights": 4,
            "payout_price": "3800.00",
            "security_price": "500.00",
            "status": "accepted",
            "total_price": "4500.00",
            "start_date": "2021-03-12",
            "end_date": "2021-03-16",
            "created_at": "2025-11-30T21:49:08.152Z",
            "updated_at": "2025-11-30T21:49:08.152Z"
        }
    }
}
```
