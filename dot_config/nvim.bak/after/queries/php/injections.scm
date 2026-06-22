; extends

(
 (scoped_call_expression
   scope: (name) @class
   name: (name) @method (#eq? @method "raw")
   arguments: (arguments
                (argument
                  (string
                    (string_content) @injection.content
                    (#set! injection.language "sql"))
                  )
               )
   ) @caller
 )

