# README

## Motivation

I wanted to show case my problem solving abilities by using optimal algorithms for large scale and distributed applications, in this case a URL shortener app.

The code also showcases:

- SOLID principle ✔️
- Code best practices  ✔️
- Database indexes ✔️
- Automated tests with Rspec  ✔️
- API only mode provided by Rails for fast responses ✔️

## Where to look?

Follow this [link](https://github.com/search?q=repo%3Avictorhazbun%2Fshorty+%40note+to+read&type=code
) to see the most relevant code.

## Dependencies

- Postgres 15.x
- Redis 7.x

## Setup

`bin/setup`

## Automated tests

`rspec`

## Testing the application locally

`rails s`

Short a URL:

`curl --location 'localhost:3000/url' \
--form 'long="https://gorails.com/setup/macos/13-ventura"'`

```json
{
    "id": 1,
    "short": "99hcey2kh",
    "long": "https://gorails.com/setup/macos/13-ventura",
    "created_at": "2023-10-06T17:16:53.044Z",
    "updated_at": "2023-10-06T17:16:53.044Z"
}
```

View the long URL:

`curl --location 'localhost:3000/v/99hcey2kh'`

```json
{
    "long": "https://gorails.com/setup/macos/13-ventura"
}
```

## Testing the application in the cloud (Heroku)

Short a URL:

`curl --location 'snnol.co/url' \
--form 'long="https://gorails.com/setup/macos/13-ventura"'`

```json
{
    "id": 10,
    "short": "9v28s18FX",
    "long": "https://gorails.com/setup/macos/13-ventura",
    "created_at": "2023-10-06T17:22:44.873Z",
    "updated_at": "2023-10-06T17:22:44.873Z"
}
```

View the long URL:

`curl --location 'snnol.co/v/9v28s18FX`

```json
{
    "long": "https://gorails.com/setup/macos/13-ventura"
}
```

## Contact me

victorhazbun87@gmail.com

