; extends

; sqlx::query!(r"SELECT * FROM users")
((macro_invocation
  (scoped_identifier
    path: (identifier) @_path
    name: (identifier) @_name)
  (token_tree
    (raw_string_literal
      (string_content) @injection.content)))
  (#eq? @_path "sqlx")
  (#match? @_name
    "^(query|query_as|query_as_unchecked|query_scalar|query_scalar_unchecked|query_unchecked)$")
  (#set! injection.language "sql"))

; sqlx::query!("SELECT * FROM users")
((macro_invocation
  (scoped_identifier
    path: (identifier) @_path
    name: (identifier) @_name)
  (token_tree
    (string_literal
      (string_content) @injection.content)))
  (#eq? @_path "sqlx")
  (#match? @_name
    "^(query|query_as|query_as_unchecked|query_scalar|query_scalar_unchecked|query_unchecked)$")
  (#set! injection.language "sql"))

; connection.execute("SELECT * FROM users", &[])?;
((call_expression
  function: [
    (generic_function
      function: (field_expression
        field: (field_identifier) @_method))
    (field_expression
      field: (field_identifier) @_method)
  ]
  arguments: (arguments
    .
    (_
      (string_content) @injection.content)))
  (#any-of? @_method "execute" "execute_batch" "prepare" "query" "query_row")
  (#set! injection.language "sql"))

; Regex::new(r"^\d+$")
(call_expression
  function: (scoped_identifier
    path: (identifier) @_mod
    (#any-of? @_mod "Regex")
    name: (identifier) @_fn
    (#any-of? @_fn "new"))
  arguments: (arguments
    [
      (raw_string_literal)
      (string_literal)
    ] @injection.content)
  (#set! injection.language "regex"))
