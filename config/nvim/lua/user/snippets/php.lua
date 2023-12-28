return {
  {
    s('pubf',
      {
        fmt({
            "public function (<>): <>",
            "{",
            "    <>",
            "}",
          },
          {
            i(1),
            i(2),
            i(3),
          }
        ),
      }
    )
  },
  {
    s('autotest', t('this is an auto test'))
  }
}
