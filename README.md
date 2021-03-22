# T&C Generator

The T&C generator is software which given:

- A template
- A dataset

Transforms the template into a Document expanding the template tags into their representation
using the dataset.

## Installation

1- install gems

```bash
$ bundle
```

2- run rack application on the default port 9292

```bash
$ rackup
```

## Usage

post request to <http://localhost:9292> with the json data.

```bash
$ curl -v -H "Content-type: application/json" -d '{ "template": "this is template [CLAUSE-1]. [SECTION-1] - [CLAUSE-2]", "dataset": { "clauses": [ { "id": 1, "text": "clause1 text"}, { "id": 2, "text": "clause2 text"} ], "sections": [{ "id": 1, "clauses_ids": [1, 2]}] } }' http://localhost:9292
```

This should output the document:

```bash
this is template clause1 text. clause1 text;clause2 text - clause2 text
```

## Run Tests

```bash
$ rspec tests/handlers/generate_TC_handler_tests.rb
```

## Design Decisions

### Assumptions

- ids of clauses and sections should be integers.
- accept requests that don't have dataset object.
- not replacing clause and section tags whose ids don't exist in the dataset.
- for sections whose clauses don't exist in the dataset, each missing clause replaced with an empty string.

### Code Structure

- A simple web service using ruby rack.
- A flexible router to map requests to handlers with the ability to be extended to support more end points.
- A generic code structure so that it can be extended to support new tag types without changing the main handler.
- A parser to parse the template and dataset with the ability to add easly more parse functions for new tag types.

- A parent Tag class with subclass for each tag type that contains also the replacer method and regex.
- If we want to add new tag type, we just create new class that inherits from Tag class and create its parse function in the parser class.

## How much time I took?

Nearly seven hours.

## What I would have done given more time?

- create middleware to validate http requests.
- create middleware to support multiple output forms.
- make tests more readable.