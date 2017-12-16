# rails5-docker-alpine

This is a very lightweight Docker image based on Ruby Alpine to run a Rails 5
application.
I also provide a docker-compose file to run your project using a PostgreSQL
database.

## Trying out the image

Clone the repository:

```sh
git clone git@github.com:pacuna/rails5-docker-alpine.git
```

Create a new Rails application under the repository directory

```sh
cd rails-docker-alpine
rails new . --database=postgresql
```

Modify your database configuration to use the postgresql container configuration:

```yaml
default: &default
  adapter: postgresql
  encoding: unicode
  # For details on connection pooling, see rails configuration guide
  # http://guides.rubyonrails.org/configuring.html#database-pooling
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  host: db
  username: postgres
```

Build and start the project:

```sh
docker-compose up -d --build
```

Create the database and run the migrations:

```
docker-compose run --rm web bin/rails db:create
docker-compose run --rm web bin/rails db:migrate
```

Visit your application at localhost:3000.

Tested with:
- ruby 2.4.2p198 (2017-09-14 revision 59899) [x86_64-linux]
- Rails 5.0.6 (to create the new application)
- Docker version 1.13.1, build fbadd78-unsupported
- docker-compose version 1.17.1, build 6d101fb
