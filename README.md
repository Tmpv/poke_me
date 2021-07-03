# POKE ME API

API giving some very basic information for pokemons.
It uses as source `https://pokeapi.co/docs/v2`

We expose only resources for:
  * Pokemons: The basic pokemons attributes
  * Pokemon kinds: The type of the pokemon

# Project setup

We have two ways to run the application:
  * Installing every component on our local environment
  * Using docker

Before going further install [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and clone this repository.

```
git clone https://github.com/Tmpv/poke_me.git
```

### The boring standard way

Install `ruby-2.7.3`
Use [rubyenv](https://github.com/rbenv/rbenv) to install version `2.7.3`.

Install `postgresql` [here](https://www.postgresql.org/docs/9.3/tutorial-install.html)

The application uses a user named `postgres` by default by you can change it to whatever user you wish
to use in `config/database.yml`

```
...
development:
  <<: *default
  database: poke_me_development
  user: some_postgres_user
  password: some_postgres_user_password
...
```

Install `bundler`:

```
gem install bundler
```

Install `gems`:

```
bundle install
```

We will need to create our development database and run migrations on it:

```
rake db:create
rake db:migrate
```

If there is any issue with the database, check database configurations again in `config/database.yml`

After this initial setup we can run our server:

```
raise server
```

If we go to `http://localhost:3000/api-docs`, we will see a very basic `swagger` documentation for the API.

One last step is to populate the database with data from `pohttps://pokeapi.co/docs/v2`

```
`rake poke_api:update_all`
```

Go to `http://localhost:3000/api/v1/pokemons/1` and you should see information the most awesome pokemon.

### The docker way

Using docker it's a lot easier.
We need to install [docker](https://docs.docker.com/engine/install/) and [docker-compose](https://docs.docker.com/compose/install/).

Build the project:

```
docker-compose build
```

After the build is ready, we just need to create our database and run our migrations.

```
docker-compose run --rm web rake db:create
```

```
docker-compose run --rm web rake db:migrate
```

We should be able to open a swagger documentation: `http://localhost:3000/api-docs`

In order to populate our database we run:

```
docker-compose run --rm web rake poke_api:update_all
```

Go to `http://localhost:3000/api/v1/pokemons/1` and you should see information the most awesome pokemon.
