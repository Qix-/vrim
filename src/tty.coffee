
keyMap =
    '8':    [8,    8,    8   ]
    '9':    [9,    null, null]
    '13':   [13,   13,   13  ]
    '16':   [null, null, null]
    '17':   [null, null, null]
    '18':   [null, null, null]
    '19':   [null, null, null]
    '20':   [null, null, null]
    '27':   [27,   96,   27  ]
    '32':   [32,   0,    32  ]
    '33':   [null, null, null]
    '34':   [null, null, null]
    '35':   [null, null, null]
    '36':   [null, null, null]
    '37':   [null, null, null]
    '38':   [null, null, null]
    '39':   [null, null, null]
    '40':   [null, null, null]
    '45':   [null, null, null]
    '46':   [null, null, null]
    '48':   [48,   48,   41  ]
    '49':   [49,   49,   33  ]
    '50':   [50,   null, 64  ]
    '51':   [51,   27,   35  ]
    '52':   [52,   28,   36  ]
    '53':   [53,   29,   37  ]
    '54':   [54,   30,   94  ]
    '55':   [55,   31,   38  ]
    '56':   [56,   127,  42  ]
    '57':   [57,   57,   40  ]
    '65':   [97,   1,    65  ]
    '66':   [98,   2,    66  ]
    '67':   [99,   3,    67  ]
    '68':   [100,  4,    68  ]
    '69':   [101,  5,    69  ]
    '70':   [102,  6,    70  ]
    '71':   [103,  7,    71  ]
    '72':   [104,  8,    72  ]
    '73':   [105,  9,    73  ]
    '74':   [106,  10,   74  ]
    '75':   [107,  11,   75  ]
    '76':   [108,  12,   76  ]
    '77':   [109,  13,   77  ]
    '78':   [110,  14,   78  ]
    '79':   [111,  15,   79  ]
    '80':   [112,  16,   80  ]
    '81':   [113,  17,   81  ]
    '82':   [114,  18,   82  ]
    '83':   [115,  19,   83  ]
    '84':   [116,  20,   84  ]
    '85':   [117,  21,   85  ]
    '86':   [118,  22,   86  ]
    '87':   [119,  23,   87  ]
    '88':   [120,  24,   88  ]
    '89':   [121,  25,   89  ]
    '90':   [122,  26,   90  ]
    '91':   [null, null, null]
    '92':   [null, null, null]
    '93':   [null, null, null]
    '96':   [48,   48,   48  ]
    '97':   [49,   49,   49  ]
    '98':   [50,   50,   50  ]
    '99':   [51,   51,   51  ]
    '100':  [52,   52,   52  ]
    '101':  [53,   53,   53  ]
    '102':  [54,   54,   54  ]
    '103':  [55,   55,   55  ]
    '104':  [56,   56,   56  ]
    '105':  [57,   57,   57  ]
    '106':  [42,   42,   42  ]
    '107':  [43,   43,   43  ]
    '109':  [45,   45,   45  ]
    '110':  [46,   46,   46  ]
    '111':  [47,   47,   47  ]
    '112':  [null, null, null]
    '113':  [null, null, null]
    '114':  [null, null, null]
    '115':  [null, null, null]
    '116':  [null, null, null]
    '117':  [null, null, null]
    '118':  [null, null, null]
    '119':  [null, null, null]
    '120':  [null, null, null]
    '121':  [null, null, null]
    '122':  [null, null, null]
    '123':  [null, null, null]
    '144':  [null, null, null]
    '145':  [null, null, null]
    '186':  [59,   59,   58  ]
    '187':  [61,   61,   43  ]
    '188':  [44,   44,   60  ]
    '189':  [45,   31,   95  ]
    '190':  [46,   46,   62  ]
    '191':  [47,   31,   63  ]
    '192':  [96,   96,   126 ]
    '219':  [91,   27,   123 ]
    '220':  [92,   28,   124 ]
    '221':  [93,   29,   125 ]
    '222':  [39,   39,   34  ]

module.exports =

  keyEventToBuffer: (e) ->
    ctrl = e.ctrlKey
    shift = if ctrl then false else e.shiftKey

    modifier = switch
      when ctrl then 1
      when shift then 2
      # when shift and ctrl then 3 # TODO this is relevant! Needs to be added.
      else 0

    codePoint = keyMap[e.keyCode]
    if not codePoint? or codePoint[modifier] is null
      console.warn "unknown character code <#{e.keyCode.toString(16)}/#{e.keyCode.toString(10)}> (#{e.key})"
      new Buffer 0
    else
      code = codePoint[modifier]
      if code instanceof String
        buffer = new Buffer code
      else
        buffer = new Buffer 1
        buffer.writeUInt8 code, 0
      buffer
