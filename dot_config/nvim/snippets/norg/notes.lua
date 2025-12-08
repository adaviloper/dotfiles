return
  {
    s(
      "review",
      fmta([[
      #question
      >> <question>
      >> Selected: <selected>
      >> <selected_explanation>
      >> 
      >> Correct: <correct>
      >> <correct_explanation>
      ]],
      {
        question = i(1, ''),
        selected = i(2, ''),
        selected_explanation = i(3, ''),
        correct = i(4, ''),
        correct_explanation = i(5, ''),
      }
      )
    ),
  },
  {
    s(
      "awsres",
      fmta([[
      **** AWS Shared Responsibility Model
      - Customer:
      -- Customer data
      -- Client-side data encryption
      - AWS:
      -- Server-side encryption
      -- Network traffic-protection
      -- Platform and application management
      -- OS, network, firewall configuration
      -- Software for compute, storage, database, and networking
      -- Hardware, AWS global infrastructure
      ]],
      {
      }
      )
    ),
    s(
      "blist",
      fmta([[
      Benefits:
      - <cursor>
      ]],
      {
        cursor = i(1, '')
      }
      )
    ),
    s(
      "uclist",
      fmta([[
      Use case:
      - <cursor>
      ]],
      {
        cursor = i(1, '')
      }
      )
    ),
  }
