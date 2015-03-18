# poc-service

This document is intended to describe and define the REST api for the **poc-service** gem.

### >> poc-server/healthcheck
**GET**

* **Summary**: retrieves health information pertaining to this service
* **Query Parameters**: None
* **Notes**: None
* **Sample Response**

        {
            "sinatra": "Up",
            "mongo": "Up",
            "poc_count": 0
        }

### >> poc-server/version
**GET**

* **Summary**: retrieves the version of the gem
* **Query Parameters**: None
* **Notes**: None
* **Sample Response**

        {
            "version": "1.0.0.0"
        }

### >> poc-service/db-props
**GET**

* **Summary**: retrieves the connection properties to the mongo database.
* **Query Parameters**: None
* **Notes**: Passwords are stripped from data transfer
* **Sample Response**

        {
            "host": "localhost",
            "port": 27017,
            "database": "poc"
        }

### Endpoints to document

> >> poc-service/pocs GET
> >> poc-service/poc POST
> >> poc-service/poc/{:poc_id} GET
> >> poc-service/poc/{:poc_id} PUT
> >> poc-service/poc/{:poc_id} DELETE
