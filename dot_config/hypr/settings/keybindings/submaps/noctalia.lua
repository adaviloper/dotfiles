hl.bind(hyper .. " + COMMA", hl.dsp.submap("noctalia"))

hl.define_submap('noctalia', function()
  hl.bind("COMMA", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call settings open"))
  hl.bind("C", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call launcher settings"))

  hl.bind("Escape", hl.dsp.submap("reset"))
end)
