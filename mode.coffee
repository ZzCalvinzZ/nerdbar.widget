command: "sh ./nerdbar.widget/scripts/screens.sh"

refreshFrequency: 100 # ms

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="./nerdbar.widget/colors.css" />
    <div class='kwmmode'></div>
  """

style: """
  -webkit-font-smoothing: antialiased
  left: 10px
  top: 5px
  width:850px
  cursor: pointer;
"""

update: (output, domEl) ->
  values = output.split('@')

  file = ""
  screenhtml = ""
  mode = values[0]
  screens = values[1]
  wins = values[2]
  win = ""
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

  icons = {
    "1": '',
    "2": '',
    "3": '',
    "4": '',
    "5": '',
    "6": '',
    "7": '',
    "8": '',
  }

  #apply a proper number tag so that space change controls can be added
  for sseg in screensegs
    i += 1
    # the active space has a closing paren aroound the name
    if sseg.slice(-1) == ")"
      screenhtml += "<span class='icon screen#{i}'>&nbsp#{i}#{icons[i]}&nbsp&nbsp</span>"
    else
      screenhtml += "<span class='icon white screen#{i}'>&nbsp#{i}#{icons[i]}&nbsp&nbsp</span>"

  console.log screenhtml

  #display the html string
  $(domEl).find('.kwmmode').html(screenhtml)

  ## add screen changing controls to the screen icons
  #$(".screen1").on 'click', => @run "osascript -e 'tell application \"System Events\" to key code 18 using control down'"
  #$(".screen2").on 'click', => @run "osascript -e 'tell application \"System Events\" to key code 19 using control down'"
  #$(".screen3").on 'click', => @run "osascript -e 'tell application \"System Events\" to key code 20 using control down'"
  #$(".screen4").on 'click', => @run "osascript -e 'tell application \"System Events\" to key code 21 using control down'"

  ## cycle through KWM space modes by clicking on the mode icon or mode name
  #if /bsp/.test(mode) == true
    #$(".tilingMode").on 'click', => @run "/usr/local/bin/kwmc space -t float"
  #else if /float/.test(mode) == true
    #$(".tilingMode").on 'click', => @run "/usr/local/bin/kwmc space -t monocle"
  #else
    #$(".tilingMode").on 'click', => @run "/usr/local/bin/kwmc space -t bsp"
