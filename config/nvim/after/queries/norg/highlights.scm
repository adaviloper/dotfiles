; extends

(quote
  (strong_carryover_set
    (strong_carryover
      name: (tag_name
              (word)
              )
      ) @BugCarryoverIcon (#set! conceal "") (#eq? @BugCarryoverIcon "#bug")
    )
  )

(
 (quote
   (strong_carryover_set
     (strong_carryover
       name: (tag_name
               (word)
               )
       ) @name (#eq? @name "#bug")
     )
   . (quote1
       (quote1_prefix)
       content: (
                 (paragraph) @BugCarryoverHeader
                 )
       )
   )
 (#set! priority 101)
 )



(quote
  (strong_carryover_set
    (strong_carryover
      name: (tag_name
              (word)
              )
      ) @InfoCarryOverIcon (#set! conceal "󰋽") (#eq? @InfoCarryOverIcon "#info")
    )
  )

(
 (quote
   (strong_carryover_set
     (strong_carryover
       name: (tag_name
               (word)
               )
       ) @name (#eq? @name "#info")
     )
   . (quote1
       (quote1_prefix)
       content: (
                 (paragraph) @InfoCarryoverHeader
                 )
       )
   )
 (#set! priority 101)
 )



(quote
  (strong_carryover_set
    (strong_carryover
      name: (tag_name
              (word)
              )
      ) @NoteCarryOverIcon (#set! conceal "") (#eq? @NoteCarryOverIcon "#note")
    )
  )

(
 (quote
   (strong_carryover_set
     (strong_carryover
       name: (tag_name
               (word)
               )
       ) @name (#eq? @name "#note")
     )
   . (quote1
       (quote1_prefix)
       content: (
                 (paragraph) @NoteCarryoverHeader
                 )
       )
   )
 (#set! priority 101)
 )

(quote
  (strong_carryover_set
    (strong_carryover
      name: (tag_name
              (word)
              )
      ) @QuestionCarryOverIcon (#set! conceal "") (#eq? @QuestionCarryOverIcon "#question")
    )
  )

(
 (quote
   (strong_carryover_set
     (strong_carryover
       name: (tag_name
               (word)
               )
       ) @name (#eq? @name "#question")
     )
   . (quote1
       (quote1_prefix)
       content: (
                 (paragraph) @QuestionCarryoverHeader
                 )
       )
   )
 (#set! priority 101)
 )


(quote
  (strong_carryover_set
    (strong_carryover
      name: (tag_name
              (word)
              )
      ) @QuoteCarryOverIcon (#set! conceal "󱆧") (#eq? @QuoteCarryOverIcon "#quote")
    )
  )

(
 (quote
   (strong_carryover_set
     (strong_carryover
       name: (tag_name
               (word)
               )
       ) @name (#eq? @name "#quote")
     )
   . (quote1
       (quote1_prefix)
       content: (
                 (paragraph) @QuoteCarryoverHeader
                 )
       )
   )
 (#set! priority 101)
 )


(quote
  (strong_carryover_set
    (strong_carryover
      name: (tag_name
              (word)
              )
      ) @SuccessCarryOverIcon (#set! conceal "󰄬") (#eq? @SuccessCarryOverIcon "#success")
    )
  )

(
 (quote
   (strong_carryover_set
     (strong_carryover
       name: (tag_name
               (word)
               )
       ) @name (#eq? @name "#success")
     )
   . (quote1
       (quote1_prefix)
       content: (
                 (paragraph) @SuccessCarryoverHeader
                 )
       )
   )
 (#set! priority 101)
 )

(quote
  (strong_carryover_set
    (strong_carryover
      name: (tag_name
              (word)
              )
      ) @WarningCarryOverIcon (#set! conceal "") (#eq? @WarningCarryOverIcon "#warning")
    )
  )

(
 (quote
   (strong_carryover_set
     (strong_carryover
       name: (tag_name
               (word)
               )
       ) @name (#eq? @name "#warning")
     )
   . (quote1
       (quote1_prefix)
       content: (
                 (paragraph) @WarningCarryoverHeader
                 )
       )
   )
 (#set! priority 101)
 )

