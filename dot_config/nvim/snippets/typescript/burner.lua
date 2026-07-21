return
  {
    s(
      {
        trig = "bb_start",
      },
      fmta(
        [[
import { NS } from '@ns';

export async function main(ns: NS) {
  <cursor>
}
      ]],
        {
          cursor = i(1, ''),
        }
      )
    ),
  },
  {
  }
