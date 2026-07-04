hl.bind(hyper .. " + COMMA", hl.dsp.submap("noctalia"))

hl.define_submap('noctalia', function()
  hl.bind("COMMA", hl.dsp.exec_cmd("noctalia msg settings-open"))
  hl.bind("C", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher settings"))

  hl.bind("Escape", hl.dsp.submap("reset"))
end)
