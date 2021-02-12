# Simple Ruby App
This is a small start point for a simple ruby app.

# Developing
Add ruby files/folders to `app/`. Add commands to run to `app.rb` (i.e `AppLogger.info("Hello World")`).

# Running
## Docker
Build the docker (need to run the first time and any time `Gemfile` is changed)
```
docker build -t simple_ruby_app .
```
Run docker (need to run build again if `--volume` not used)
```
docker run --volume "$PWD:/usr/src/app" -it simple_ruby_app
```
## Docker compose
Build the docker compose if other services are needed (i.e. mongo, MySQL...)
```
docker-compose build
```
Run docker (need to run build again if `--volume` not used)
```
docker-compose run app
```
