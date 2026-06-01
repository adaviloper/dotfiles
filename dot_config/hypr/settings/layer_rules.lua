hl.layer_rule({
  name = "noctalia",
  match = {
    namespace = "noctalia-background-.*$"
  },
  ignore_alpha = 0.2,
  blur = true,
  blur_popups = true,
})

