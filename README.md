# Movie App
## Built with Rails, Devise, RSpec, FactoryGirl

To view API responses, run the server using `rails s`, and then use Postman or cURL!

```
$ curl -v http://localhost:3000/films/2

{"films":[{"id":2,"title":"Awesome Movie","description":"So good","url_slug":"foo","year":2018,"average_rating":0.0,"related_film_ids":[]}]}
```