return {
  'adaviloper/telescope-env',
  config = function ()
    require('telescope-env')
    require('telescope').load_extension('telescope-env')
  end
}
