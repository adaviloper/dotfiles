; extends

(
 (pair
   key: (string (string_content) @key (#eq? @key "scripts"))
   value: (object
            (pair
              value: (array
                       (string
                         (string_content) @injection.content)
                       (#set! injection.language "bash")
                       )
              )
            )
   )
 )


(pair
  key: (string (string_content) @key (#eq? @key "scripts"))
  value: (object
    (pair
      key: (string) 
      value: (string
       (string_content) @injection.content
       (#set! injection.language "bash"))
    )
  )
)
