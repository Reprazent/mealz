# Mealz

An rails app used to track who needs to go to the shop.

Everytime someome goes to the shop they need to tell our hubot how much they spent, and who ate with them.
Hubot will then pass the information on to this app, where it will be stored.

When the time comes to decide who needs go scavenging next, hubot will be able to answer the question.

The person who payed the least, will need to go.

## Setup

Make sure you have the following dependencies installed:

- Postgres
- forego
- Ruby 2.2.1

Then, running `script/bootstrap` should get you going.

Run the tests using `rake`.

## The API

- [ ] Creating meals
- [ ] Getting balance for one user
- [ ] Getting balance for all users
