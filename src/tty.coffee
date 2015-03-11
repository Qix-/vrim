
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


  TTYBuffer: class TTYBuffer
    constructor: (@width, @height) ->
      @buffer = [[]]
      @escaped = false
      @escapeArgs = []
      @escapeArgBuf = ''
      @cursor = [0, 0] # x = x; y = @buffer.length - y

      @colors = [
        # Normal intensity
        0x000000
        0x800000
        0x008000
        0x808000
        0x000080
        0x800080
        0x008080
        0xc0c0c0

        # Bright intensity
        0x808080
        0xff0000
        0x00ff00
        0xffff00
        0x0000ff
        0xff00ff
        0x00ffff
        0xffffff

        # 256 color extensions 
        0x000000
        0x00005f
        0x000087
        0x0000af
        0x0000d7
        0x0000ff
        0x005f00
        0x005f5f
        0x005f87
        0x005faf
        0x005fd7
        0x005fff
        0x008700
        0x00875f
        0x008787
        0x0087af
        0x0087d7
        0x0087ff
        0x00af00
        0x00af5f
        0x00af87
        0x00afaf
        0x00afd7
        0x00afff
        0x00d700
        0x00d75f
        0x00d787
        0x00d7af
        0x00d7d7
        0x00d7ff
        0x00ff00
        0x00ff5f
        0x00ff87
        0x00ffaf
        0x00ffd7
        0x00ffff
        0x5f0000
        0x5f005f
        0x5f0087
        0x5f00af
        0x5f00d7
        0x5f00ff
        0x5f5f00
        0x5f5f5f
        0x5f5f87
        0x5f5faf
        0x5f5fd7
        0x5f5fff
        0x5f8700
        0x5f875f
        0x5f8787
        0x5f87af
        0x5f87d7
        0x5f87ff
        0x5faf00
        0x5faf5f
        0x5faf87
        0x5fafaf
        0x5fafd7
        0x5fafff
        0x5fd700
        0x5fd75f
        0x5fd787
        0x5fd7af
        0x5fd7d7
        0x5fd7ff
        0x5fff00
        0x5fff5f
        0x5fff87
        0x5fffaf
        0x5fffd7
        0x5fffff
        0x870000
        0x87005f
        0x870087
        0x8700af
        0x8700d7
        0x8700ff
        0x875f00
        0x875f5f
        0x875f87
        0x875faf
        0x875fd7
        0x875fff
        0x878700
        0x87875f
        0x878787
        0x8787af
        0x8787d7
        0x8787ff
        0x87af00
        0x87af5f
        0x87af87
        0x87afaf
        0x87afd7
        0x87afff
        0x87d700
        0x87d75f
        0x87d787
        0x87d7af
        0x87d7d7
        0x87d7ff
        0x87ff00
        0x87ff5f
        0x87ff87
        0x87ffaf
        0x87ffd7
        0x87ffff
        0xaf0000
        0xaf005f
        0xaf0087
        0xaf00af
        0xaf00d7
        0xaf00ff
        0xaf5f00
        0xaf5f5f
        0xaf5f87
        0xaf5faf
        0xaf5fd7
        0xaf5fff
        0xaf8700
        0xaf875f
        0xaf8787
        0xaf87af
        0xaf87d7
        0xaf87ff
        0xafaf00
        0xafaf5f
        0xafaf87
        0xafafaf
        0xafafd7
        0xafafff
        0xafd700
        0xafd75f
        0xafd787
        0xafd7af
        0xafd7d7
        0xafd7ff
        0xafff00
        0xafff5f
        0xafff87
        0xafffaf
        0xafffd7
        0xafffff
        0xd70000
        0xd7005f
        0xd70087
        0xd700af
        0xd700d7
        0xd700ff
        0xd75f00
        0xd75f5f
        0xd75f87
        0xd75faf
        0xd75fd7
        0xd75fff
        0xd78700
        0xd7875f
        0xd78787
        0xd787af
        0xd787d7
        0xd787ff
        0xd7af00
        0xd7af5f
        0xd7af87
        0xd7afaf
        0xd7afd7
        0xd7afff
        0xd7d700
        0xd7d75f
        0xd7d787
        0xd7d7af
        0xd7d7d7
        0xd7d7ff
        0xd7ff00
        0xd7ff5f
        0xd7ff87
        0xd7ffaf
        0xd7ffd7
        0xd7ffff
        0xff0000
        0xff005f
        0xff0087
        0xff00af
        0xff00d7
        0xff00ff
        0xff5f00
        0xff5f5f
        0xff5f87
        0xff5faf
        0xff5fd7
        0xff5fff
        0xff8700
        0xff875f
        0xff8787
        0xff87af
        0xff87d7
        0xff87ff
        0xffaf00
        0xffaf5f
        0xffaf87
        0xffafaf
        0xffafd7
        0xffafff
        0xffd700
        0xffd75f
        0xffd787
        0xffd7af
        0xffd7d7
        0xffd7ff
        0xffff00
        0xffff5f
        0xffff87
        0xffffaf
        0xffffd7
        0xffffff
        0x080808
        0x121212
        0x1c1c1c
        0x262626
        0x303030
        0x3a3a3a
        0x444444
        0x4e4e4e
        0x585858
        0x606060
        0x666666
        0x767676
        0x808080
        0x8a8a8a
        0x949494
        0x9e9e9e
        0xa8a8a8
        0xb2b2b2
        0xbcbcbc
        0xc6c6c6
        0xd0d0d0
        0xdadada
        0xe4e4e4
        0xeeeeee
      ]

    resetDisplay: ->
      @displayMode =
        fgColor: @colors[8]
        fgBright: 0 # 1 = bold, -1 = faint
        bgColor: @colors[0]
        bgBright: false
        inverse: false
        blink: 0 # 1 = slow, 2 = rapid
        underline: false
        concealed: false
        strikethrough: false
        italic: false
        frame: false
        # circled would be too stupidly hard and futile
        overline: false

        # for color specification:
        colorLoc: 0 # 3 = foreground, 4 = background
        colorMod: 0 # -1 = specified 3/48, 2 = rgb, 5 = 256
        colorArgs: []

    write: (buffer) ->
      @pushByte buffer[i] for i in [0...buffer.length]

    pushByte: (b) ->
      if @escaped
        switch
          when b is 0x3b # ;
            @escapeArgs.push parseInt @escapeArgBuf
            @escapeArgs = ''
          when b >= 30 and b <= 39 then @escapeArgBuf += String.fromCharCode b
          when b is 0x6d # m
            @pushByte 0x3b # simulate semicolon
            @escaped = false

            for m in @escapeArgs
              # switch color mode
              switch
                when @displayMode.colorMod is -1
                  switch m
                    when 2 then @displayMode.colorMod = 2
                    when 5 then @displayMode.colorMod = 5
                    else
                      # if invalid colormod, then we ignore the color
                      # transition altogether
                      @displayMode.colorMod = 0
                when @displayMode.colorMod is 2
                  @displayMode.colorArgs.push Math.max 0, Math.min 256, m
                  if @displayMode.colorArgs.length is 3
                    location = switch @displayMode.colorLoc
                      when 3 then 'fgColor'
                      when 4 then 'bgColor'
                    @displayMode[location] =
                      (@displayMode.colorArgs[0] << 16) |
                      (@displayMode.colorArgs[1] << 8) |
                      @displayMode.colorArgs[2]
                    @displayMode.colorArgs = []
                    @displayMode.colorLoc = 0
                    @displayMode.colorMod = 0
                when @displayMode.colorMod is 5
                  if m >= 0 and m <= 255
                    location = switch @displayMode.colorLoc
                      when 3 then 'fgColor'
                      when 4 then 'bgColor'
                    @displayMode[location] = @colors[parseInt m]

                  @displayMode.colorLoc = 0
                  @displayMode.colorMod = 0
                  @displayMode.colorArgs = []
                when m is 0
                  @resetDisplay()
                when m is 1 then @displayMode.fgBright = 1
                when m is 2 then @displayMode.fgBright = -1
                when m is 3 then @displayMode.italic = true
                when m is 4 then @displayMode.underline = true
                when m is 5 then @displayMode.blink = 1
                when m is 6 then @displayMode.blink = 2
                when m is 7 then @displayMode.inverse = true
                when m is 8 then @displayMode.concealed = true
                when m is 9 then @displayMode.strikethrough = true
                when m is 21 and @displayMode.fgBright is 1
                  @displayMode.fgBright = 0
                when m is 22 then @displayMode.fbBright = 0
                when m is 23 then @displayMode.italic = false
                when m is 24 then @displayMode.underline = false
                when m is 25 then @displayMode.blink = 0
                when m is 27 then @displayMode.inverse = false
                when m is 28 then @displayMode.concealed = false
                when m is 29 then @displayMode.strikethrough = false
                when m >= 30 and m <= 37
                  @displayMode.fgColor = @colors[m - 30]
                when m is 38
                  @displayMode.colorMod = -1
                  @displayMode.colorLoc = 3
                when m is 39 then @displayMode.fgColor = @colors[7]
                when m >= 40 and m <= 47
                  @displayMode.bgColor = @colors[m - 40]
                when m is 48
                  @displayMode.colorMod = -1
                  @displayMode.colorLoc = 4
                when m is 49 then @displayMode.bgColor = @colors[0]
                when m is 51 then @displayMode.frame = true
                when m is 53 then @displayMode.overline = true
                when m is 54 then @displayMode.frame = false
                when m is 55 then @displayMode.overline = false
                when m >= 90 && m <= 97
                  @displayMode.fgColor = @colors[m - 90]
                  @displayMode.fgBright = 1
                when m >= 100 && m <= 107
                  @displayMode.bgColor = @colors[m - 100]
                  @displayMode.bgBright = 1
          when b is 0x41 # A
            @escaped = false
            @cursor[1] -= if @escapeArgs[0]? then @escapeArgs[0] else 1
            @cursor[1] = Math.max -@buffer.length, @cursor[1] + 1
          when b is 0x42 # B
            @escaped = false
            @cursor[1] += if @escapeArgs[0]? then @escapeArgs[0] else 1
            @cursor[1] = Math.min @cursor[1], 0
          when b is 0x43 # C
            @escaped = false
            @cursor[0] += if @escapeArgs[0]? then @escapeArgs[0] else 1
            @cursor[0] = Math.min @cursor[0], @width - 1
          when b is 0x44 # D
            @escaped = false
            @cursor[0] -= if @escapeArgs[0]? then @escapeArgs[0] else 1
            @cursor[0] = Math.max @cursor[0], 0
          when b is 0x45 # E
            @escaped = false
            @cursor[0] = 0
            @cursor[1] += if @escapeArgs[0]? then @escapeArgs[0] else 1
            @cursor[1] = Math.min @cursor[1], 0
          when b is 0x46 # F
            @escaped = false
            @cursor[0] = 0
            @cursor[1] -= if @escapeArgs[0]? then @escapeArgs[0] else 1
            @cursor[1] = Math.max -@buffer.length, @cursor[1] + 1
          when b is 0x47 # G
            @escaped = false
            @cursor[0] = Math.min @width, @escapeArgs[0]
          # TODO finish up codes
      else
        switch
          when b is 0x1b then @escaped = true # ESC
          when b is 0x00 then @pushCharcters '^@'
          else @pushCharacterByte b

    pushCharacterByte: (b) ->
      @pushCharacters String.fromCharCode b

    pushCharacters: (chrs) ->
      # XXX TODO
