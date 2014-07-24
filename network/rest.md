REST is an HTTP API style.

This shall discuss common design patterns for such APIs.

Good way to learn: see famous APIs:

- GitHub: <https://developer.github.com/v3/>
- Dropbox: <https://www.dropbox.com/developers/core/docs>

# File upload

## Together with other data

Taken from this [discussion](http://feedback.gitlab.com/forums/176466-general/suggestions/3865548-api-to-attach-attachments-to-notes-issue-comments) on how to attack files to comments from API.

Comments and most of the creation API were currently created by JSON POST requests.

Possibilities:

- single URL, two accepted content types:

  - `multipart/form-data` with two parts: one JSON metadata (currently only "body" for notes),
    one part for the file.

  - `application/json`: just the JSON metadata, in case the file is empty.

  My preferred option, as it keeps most data in JSON format as the rest of the API,
  note creation takes a single HTTP request, generalises well for multiple files.

- Two separate URLs: one for metadata via JSON, one for the file, with file data on body.

  Downsides:

  - note create / update takes multiple HTTP requests
  - on create, the user has to do the extra work of interpretation
  - occupies 1 URL namespaces for each uploaded file

  Upside: simpler for us to implement.

- `multipart/form-data`, one part for each field.

  This is how the web interface (non-API) upload currently works.
  Simple because already implemented, but not coherent with the rest of the API since no JSON used.

- ASCII encode the upload and send on JSON.

  Best way to do it: <http://stackoverflow.com/questions/1443158/binary-data-in-json-string-something-better-than-base64>

# Pagination

GitHub v3: link header as:

    Link: <https://api.github.com/search/code?q=addClass+user%3Amozilla&page=2>; rel="next",
      <https://api.github.com/search/code?q=addClass+user%3Amozilla&page=34>; rel="last"

Info: <https://developer.github.com/guides/traversing-with-pagination>
