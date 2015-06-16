# Lightning

To start your new Phoenix application:

1. Install dependencies with `mix deps.get`
2. Install node dependecies with `npm install`
3. Install PhantomJS and start with `phantomjs --webdriver=8910`.
4. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit `localhost:4000` from your browser.
To test run:
`curl -X POST -HContent-Type:application/json -d'{"data":
{"product_name": "Apple"}, "script": ["goto http://amazon.com", "enter
:product_name in #twotabsearchtextbox", "click input[type='submit']"]}'
http://localhost:4000/api/scripts`
