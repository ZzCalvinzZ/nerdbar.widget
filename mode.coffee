command: "sh ./nerdbar.widget/scripts/screens.sh"

refreshFrequency: 100 # ms

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="./nerdbar.widget/colors.css" />
    <div class='kwmmode' style='height: 100%; display: flex;'></div>
  """

style: """
  left: 10px
  top: 0px
  height: 21px
  width: 25%
  cursor: pointer
"""

update: (output, domEl) ->
  values = output.split('@')

  screenhtml = ""
  screens = values[1]
  i = 0

  # The script ouputs the space names in parens so you can split them here. The
  # script outputs the names of the screens, if you prefer to use those instead
  # of generic indicators.
  screensegs = screens.split('(')

  for sseg in screensegs
    screensegs[i] = sseg.replace /^\s+|\s+$/g, ""
    i+=1

  screensegs = (x for x in screensegs when x != '')

  i = 0

  icons = ['', ' ', ' ', ' ', ' ', ' ', ' ', '', '']

  #apply a proper number tag so that space change controls can be added
  for sseg in screensegs
    i += 1
    # the active space has a closing paren aroound the name
    if sseg.slice(-1) == ")"
      screenhtml += "<div class='screen icon active-screen' style=''><span class='screen-val'>&nbsp#{i}#{icons[i]}&nbsp&nbsp</span></div>"
    else
      screenhtml += "<div class='screen icon'><span class='screen-val'>&nbsp#{i}#{icons[i]}&nbsp&nbsp</span></div>"

  console.log screenhtml

  #display the html string
  $(domEl).find('.kwmmode').html(screenhtml)
