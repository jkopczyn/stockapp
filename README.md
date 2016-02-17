# StockApp

Simple app using the Yahoo Finance API and the yahoofinance gem to manage a
simple stock portfolio.

## Structure outline

User model with password and session management, as well as balance outstanding.
  * new, create, show, edit, update

Stock model stores a ticker symbol (immutable), last known price, and time of 
last check. Any action using this will check the finance client unless time of
last check is a minute or less in the past. (This can be batched and should be
where possible.)
  * show, create, user:index

Transaction model can be :buy or :sell, and is immutable once created. It is
linked to a user and a stock, together with a quantity, time, and (just for
cachng) the price at that time.
  * new, create
