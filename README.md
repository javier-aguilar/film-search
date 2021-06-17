# Film Search API

Film Search is an API built on Rails that provides data on films.

## Test Deployment

The API can be reached here: https://film-search-api.herokuapp.com/

## Setup

### Versions

- Ruby 2.6.7
- Rails 5.2.6

### Install

```shell
$ git clone https://github.com/javier-aguilar/film-search.git
$ cd film-search
$ bundle install
$ rails db:{create,migrate}
$ export api_key=<Your_MovieDB_API_Key>
$ rails s
```

## API Documentation

See: https://film-search-api.herokuapp.com/api-docs

### Search for film

Returns film info

```shell
GET /film/search/query=<keyword>
```

Example:

```shell
GET /film/search/query=alien
```

#### Required Params

|           |         |
| --------- | :-----: |
| **query** | keyword |

#### Optional Params

|             |                   |
| ----------- | :---------------: |
| **sort_by** | 'title' OR 'year' |
| **order**   |  'asc' OR 'desc'  |
| **filter**  |      keyword      |
