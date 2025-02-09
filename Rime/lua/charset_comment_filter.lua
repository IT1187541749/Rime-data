-- encoding: utf-8


--- charset filter
local charset = {
   ["基本"] = { first = 0x4e00, last = 0x9fff },
   ["扩A"] = { first = 0x3400, last = 0x4dbf },
   ["扩B"] = { first = 0x20000, last = 0x2a6dd },
   ["扩C"] = { first = 0x2a700, last = 0x2b734 },
   ["扩D"] = { first = 0x2b740, last = 0x2b81d },
   ["扩E"] = { first = 0x2b820, last = 0x2cea1 },
   ["扩F"] = { first = 0x2ceb0, last = 0x2ebe0 },
   ["扩G"] = { first = 0x30000, last = 0x3134a },
   ["扩H"] = { first = 0x31350, last = 0x323AF },
   ["扩I"] = { first = 0x2ebf0, last = 0x2ee5d },
   ["拉补"] = { first = 0x0080, last = 0x00ff },
   ["拉丁"] = { first = 0x0000, last = 0x007f },
   ["私用"] = { first = 0xe000, last = 0xf8ff },
   ["私补"] = { first = 0x100000, last = 0x10ffff },
   ["符号和象形文字扩展-A"] = { first = 0x1fa70, last = 0x1faff },
   ["兼补"] = { first = 0x2f800, last = 0x2fa1f },
   ["楔形文字数字和标点符号"] = { first = 0x12400, last = 0x1247f },
   ["高加索阿尔巴尼亚语言"] = { first = 0x10530, last = 0x1056f },
   ["统一加拿大原住民音节扩展"] = { first = 0x18b0, last = 0x18ff },
   ["私补A"] = { first = 0xf0000, last = 0xffff },
   ["符号补"] = { first = 0x1f900, last = 0x1f9ff },
   ["阿拉伯字母数字符号"] = { first = 0x1ee00, last = 0x1eeff },
   ["杂符"] = { first = 0x1f300, last = 0x1f5ff },
   ["假扩A"] = { first = 0x1b100, last = 0x1b12f },
   ["安纳托利亚象形文字"] = { first = 0x14400, last = 0x1467f },
   ["表意符号和标点符号"] = { first = 0x16fe0, last = 0x16fff },
   ["线形文字B表意文字"] = { first = 0x10080, last = 0x100ff },
   ["阿拉伯语表现形式-A"] = { first = 0xfb50, last = 0xfdff },
   ["方框绘制字符(制表符)"] = { first = 0x2500, last = 0x257f },
   ["札那巴札尔方形字母"] = { first = 0x11a00, last = 0x11a4f },
   ["阿拉伯语表现形式-B"] = { first = 0xfe70, last = 0xfeff },
   ["斐斯托斯圆盘古文字"] = { first = 0x101d0, last = 0x101ff },
   ["埃及圣书体格式控制"] = { first = 0x13430, last = 0x1343f },
   ["奥斯曼西亚克数字"] = { first = 0x1ed00, last = 0x1ed4f },
   ["小型日文假名扩展"] = { first = 0x1b130, last = 0x1b16f },
   ["圈字补"] = { first = 0x1f200, last = 0x1f2ff },
   ["圈字补"] = { first = 0x1f100, last = 0x1f1ff },
   ["格拉哥里字母增补"] = { first = 0x1e000, last = 0x1e02f },
   ["尼亚坑普阿绰苗文"] = { first = 0x1e100, last = 0x1e14f },
   ["统一加拿大原住民音节"] = { first = 0x1400, last = 0x167f },
   ["圈符"] = { first = 0x3200, last = 0x32ff },
   ["哈乃斐罗兴亚文字"] = { first = 0x10d00, last = 0x10d3f },
   ["标点"] = { first = 0x3000, last = 0x303f },
   ["阿姆哈拉语扩展-A"] = { first = 0xab00, last = 0xab2f },
   ["马萨拉姆贡德文字"] = { first = 0x11d00, last = 0x11d5f },
   ["变化选择器补充"] = { first = 0xe0100, last = 0xe01ef },
   ["速记格式控制符"] = { first = 0x1bca0, last = 0x1bcaf },
   ["追加箭头-C"] = { first = 0x1f800, last = 0x1f8ff },
   ["拜占庭音乐符号"] = { first = 0x1d000, last = 0x1d0ff },
   ["交通和地图符号"] = { first = 0x1f680, last = 0x1f6ff },
   ["古希腊音乐记号"] = { first = 0x1d200, last = 0x1d24f },
   ["字母和数字符号"] = { first = 0x1d400, last = 0x1d7ff },
   ["印度西亚格数字"] = { first = 0x1ec70, last = 0x1ecbf },
   ["结合符号的变音符号"] = { first = 0x20d0, last = 0x20ff },
   ["部首"] = { first = 0x2e80, last = 0x2eff },
   ["古北部阿拉伯语"] = { first = 0x10a80, last = 0x10a9f },
   ["古南部阿拉伯语"] = { first = 0x10a60, last = 0x10a7f },
   ["麦罗埃文草体字"] = { first = 0x109a0, last = 0x109ff },
   ["奥斯曼亚字母"] = { first = 0x10480, last = 0x104af },
   ["塞浦路斯语音节"] = { first = 0x10800, last = 0x1083f },
   ["爱尔巴桑字母"] = { first = 0x10500, last = 0x1052f },
   ["德瑟雷特字母"] = { first = 0x10400, last = 0x1044f },
   ["杂项数学符号-A"] = { first = 0x27c0, last = 0x27ef },
   ["杂项数学符号-B"] = { first = 0x2980, last = 0x29ff },
   ["科普特闰余数字"] = { first = 0x102e0, last = 0x102ff },
   ["西里尔文扩展-B"] = { first = 0xa640, last = 0xa69f },
   ["西里尔文扩展-A"] = { first = 0x2de0, last = 0x2dff },
   ["韩文字母扩展-A"] = { first = 0xa960, last = 0xa97f },
   ["兼容"] = { first = 0xf900, last = 0xfaff },
   ["韩文字母扩展-B"] = { first = 0xd7b0, last = 0xd7ff },
   ["梅德法伊德林文"] = { first = 0x16e40, last = 0x16e9f },
   ["线形文字B音节"] = { first = 0x10000, last = 0x1007f },
   ["巴姆穆文字增补"] = { first = 0x16800, last = 0x16a3f },
   ["蒙古语增补"] = { first = 0x11660, last = 0x1167f },
   ["古僧伽罗文数字"] = { first = 0x111e0, last = 0x111ff },
   ["西里尔文扩展-C"] = { first = 0x1c80, last = 0x1c8f },
   ["麦罗埃象形文字"] = { first = 0x10980, last = 0x1099f },
   ["假补"] = { first = 0x1b000, last = 0x1b0ff },
   ["阿德拉姆字母"] = { first = 0x1e900, last = 0x1e95f },
   ["门德基卡库文"] = { first = 0x1e800, last = 0x1e8df },
   ["萨顿书写符号"] = { first = 0x1d800, last = 0x1daaf },
   ["几何扩"] = { first = 0x1f780, last = 0x1f7ff },
   ["结构"] = { first = 0x2ff0, last = 0x2fff },
   ["巴尔米拉字母"] = { first = 0x10860, last = 0x1087f },
   ["拉丁语扩展-A"] = { first = 0x0100, last = 0x017f },
   ["乌加里特语"] = { first = 0x10380, last = 0x1039f },
   ["古代楔形文字"] = { first = 0x12480, last = 0x1254f },
   ["易经六十四卦符号"] = { first = 0x4dc0, last = 0x4dff },
   ["萧伯纳字母"] = { first = 0x10450, last = 0x1047f },
   ["泰米尔文增补"] = { first = 0x11fc0, last = 0x11fff },
   ["贡贾拉贡德文"] = { first = 0x11d60, last = 0x11daf },
   ["拉丁语扩展-B"] = { first = 0x0180, last = 0x024f },
   ["欧塞奇字母"] = { first = 0x104b0, last = 0x104ff },
   ["拉丁语扩展-D"] = { first = 0xa720, last = 0xa7ff },
   ["希腊"] = { first = 0x0370, last = 0x03ff },
   ["结合变音符号扩展"] = { first = 0x1ab0, last = 0x1aff },
   ["缅甸语扩展-B"] = { first = 0xa9e0, last = 0xa9ff },
   ["索拉僧平文字"] = { first = 0x110d0, last = 0x110ff },
   ["鲁米数字符号"] = { first = 0x10e60, last = 0x10e7f },
   ["线性文字A"] = { first = 0x10600, last = 0x1077f },
   ["古匈牙利字母"] = { first = 0x10c80, last = 0x10cff },
   ["阿拉伯语扩展-A"] = { first = 0x08a0, last = 0x08ff },
   ["常用印度数字形式"] = { first = 0xa830, last = 0xa83f },
   ["诗篇巴列维文"] = { first = 0x10b80, last = 0x10baf },
   ["碑刻巴列维文"] = { first = 0x10b60, last = 0x10b7f },
   ["碑刻帕提亚文"] = { first = 0x10b40, last = 0x10b5f },
   ["阿维斯陀字母"] = { first = 0x10b00, last = 0x10b3f },
   ["结合变音标记增补"] = { first = 0x1dc0, last = 0x1dff },
   ["帝国阿拉姆語"] = { first = 0x10840, last = 0x1085f },
   ["古意大利字母"] = { first = 0x10300, last = 0x1032f },
   ["拉丁语扩展-C"] = { first = 0x2c60, last = 0x2c7f },
   ["缅甸语扩展-A"] = { first = 0xaa60, last = 0xaa7f },
   ["拉丁文扩展-E"] = { first = 0xab30, last = 0xab6f },
   ["多米诺骨牌"] = { first = 0x1f030, last = 0x1f09f },
   ["太玄经符号"] = { first = 0x1d300, last = 0x1d35f },
   ["炼金术符号"] = { first = 0x1f700, last = 0x1f77f },
   ["杜普雷速记"] = { first = 0x1bc00, last = 0x1bc9f },
   ["西夏文部首"] = { first = 0x18800, last = 0x18aff },
   ["拉丁语扩展附加"] = { first = 0x1e00, last = 0x1eff },
   ["圈数"] = { first = 0x2460, last = 0x24ff },
   ["补充箭头-A"] = { first = 0x27f0, last = 0x27ff },
   ["国际音标扩展"] = { first = 0x0250, last = 0x02af },
   ["间距修饰字符"] = { first = 0x02b0, last = 0x02ff },
   ["组合变音标记"] = { first = 0x0300, last = 0x036f },
   ["补充箭头-B"] = { first = 0x2900, last = 0x297f },
   ["数运补"] = { first = 0x2a00, last = 0x2aff },
   ["其他符号和箭头"] = { first = 0x2b00, last = 0x2bff },
   ["格鲁吉亚文增补"] = { first = 0x2d00, last = 0x2d2f },
   ["阿姆哈拉语扩展"] = { first = 0x2d80, last = 0x2ddf },
   ["笔画"] = { first = 0x31c0, last = 0x31ef },
   ["腓尼基字母"] = { first = 0x10900, last = 0x1091f },
   ["曼尼普尔语扩展"] = { first = 0xaae0, last = 0xaaff },
   ["字符"] = { first = 0xff00, last = 0xffef },
   ["爱琴海数字"] = { first = 0x10100, last = 0x1013f },
   ["古希腊数字"] = { first = 0x10140, last = 0x1018f },
   ["古罗马符号"] = { first = 0x10190, last = 0x101cf },
   ["卡里亚字母"] = { first = 0x102a0, last = 0x102df },
   ["古彼尔姆文"] = { first = 0x10350, last = 0x1037f },
   ["古波斯语"] = { first = 0x103a0, last = 0x103df },
   ["纳巴泰字母"] = { first = 0x10880, last = 0x108af },
   ["中日韩兼容形式"] = { first = 0xfe30, last = 0xfe4f },
   ["哈特兰字母"] = { first = 0x108e0, last = 0x108ff },
   ["古代突厥語"] = { first = 0x10c00, last = 0x10c4f },
   ["古粟特字母"] = { first = 0x10f00, last = 0x10f2f },
   ["以利买字母"] = { first = 0x10fe0, last = 0x10fff },
   ["马哈雅尼文"] = { first = 0x11150, last = 0x1117f },
   ["库达瓦迪文"] = { first = 0x112b0, last = 0x112ff },
   ["瓦兰齐地文"] = { first = 0x118a0, last = 0x118ff },
   ["索永布字母"] = { first = 0x11a50, last = 0x11aaf },
   ["拜克舒基文"] = { first = 0x11c00, last = 0x11c6f },
   ["埃及圣书体"] = { first = 0x13000, last = 0x1342f },
   ["巴萨哇文字"] = { first = 0x16ad0, last = 0x16aff },
   ["柏格理苗文"] = { first = 0x16f00, last = 0x16f9f },
   ["阿姆哈拉语增补"] = { first = 0x1380, last = 0x139f },
   ["提尔胡塔文"] = { first = 0x11480, last = 0x114df },
   ["格鲁吉亚文扩展"] = { first = 0x1c90, last = 0x1cbf },
   ["表情"] = { first = 0x1f600, last = 0x1f64f },
   ["玛雅数字"] = { first = 0x1d2e0, last = 0x1d2ff },
   ["装饰符号"] = { first = 0x1f650, last = 0x1f67f },
   ["音乐符号"] = { first = 0x1d100, last = 0x1d1ff },
   ["象棋"] = { first = 0x1fa00, last = 0x1fa6f },
   ["文乔字母"] = { first = 0x1e2c0, last = 0x1e2ff },
   ["杂项技术符号"] = { first = 0x2300, last = 0x23ff },
   ["罗马"] = { first = 0x2150, last = 0x218f },
   ["悉昙文字"] = { first = 0x11580, last = 0x115ff },
   ["切罗基语增补"] = { first = 0xab70, last = 0xabbf },
   ["西里尔文增补"] = { first = 0x0500, last = 0x052f },
   ["塔克里文"] = { first = 0x11680, last = 0x116cf },
   ["补充标点符号"] = { first = 0x2e00, last = 0x2e7f },
   ["阿洪姆语"] = { first = 0x11700, last = 0x1173f },
   ["小型变体形式"] = { first = 0xfe50, last = 0xfe6f },
   ["阿拉伯语增补"] = { first = 0x0750, last = 0x077f },
   ["索拉什特拉语"] = { first = 0xa880, last = 0xa8df },
   ["西非书面文字"] = { first = 0x07c0, last = 0x07ff },
   ["撒玛利亚字母"] = { first = 0x0800, last = 0x083f },
   ["婆罗米文"] = { first = 0x11000, last = 0x1107f },
   ["叙利亚文增补"] = { first = 0x0860, last = 0x086f },
   ["粟特字母"] = { first = 0x10f30, last = 0x10f6f },
   ["多格拉语"] = { first = 0x11800, last = 0x1184f },
   ["桑塔利语字母"] = { first = 0x1c50, last = 0x1c7f },
   ["南迪城文"] = { first = 0x119a0, last = 0x119ff },
   ["吕基亚语"] = { first = 0x10280, last = 0x1029f },
   ["包钦豪文"] = { first = 0x11ac0, last = 0x11aff },
   ["光学字符识别"] = { first = 0x2440, last = 0x245f },
   ["马拉雅拉姆语"] = { first = 0x0d00, last = 0x0d7f },
   ["吕底亚语"] = { first = 0x10920, last = 0x1093f },
   ["望加锡文"] = { first = 0x11ee0, last = 0x11eff },
   ["国际音标扩展"] = { first = 0x1d00, last = 0x1d7f },
   ["国际音标增补"] = { first = 0x1d80, last = 0x1dbf },
   ["摩尼字母"] = { first = 0x10ac0, last = 0x10aff },
   ["楔形文字"] = { first = 0x12000, last = 0x123ff },
   ["格拉哥里字母"] = { first = 0x2c00, last = 0x2c5f },
   ["塔格巴努亚文"] = { first = 0x1760, last = 0x177f },
   ["哥特字母"] = { first = 0x10330, last = 0x1034f },
   ["帕哈苗文"] = { first = 0x16b00, last = 0x16b8f },
   ["标点"] = { first = 0x2000, last = 0x206f },
   ["注音符号扩展"] = { first = 0x31a0, last = 0x31bf },
   ["韩文兼容字母"] = { first = 0x3130, last = 0x318f },
   ["字母连写形式"] = { first = 0xfb00, last = 0xfb4f },
   ["组合用半符号"] = { first = 0xfe20, last = 0xfe2f },
   ["查克马语"] = { first = 0x11100, last = 0x1114f },
   ["夏拉达文"] = { first = 0x11180, last = 0x111df },
   ["木尔坦文"] = { first = 0x11280, last = 0x112af },
   ["古兰塔文"] = { first = 0x11300, last = 0x1137f },
   ["尼瓦尔语"] = { first = 0x11400, last = 0x1147f },
   ["扑克牌"] = { first = 0x1f0a0, last = 0x1f0ff },
   ["麻将牌"] = { first = 0x1f000, last = 0x1f02f },
   ["凯提文"] = { first = 0x11080, last = 0x110cf },
   ["平假名"] = { first = 0x3040, last = 0x309f },
   ["亚美尼亚语"] = { first = 0x0530, last = 0x058f },
   ["上标和下标"] = { first = 0x2070, last = 0x209f },
   ["提非纳字母"] = { first = 0x2d30, last = 0x2d7f },
   ["古吉拉特語"] = { first = 0x0a80, last = 0x0aff },
   ["天城文扩展"] = { first = 0xa8e0, last = 0xa8ff },
   ["巽他文增补"] = { first = 0x1cc0, last = 0x1ccf },
   ["格鲁吉亚语"] = { first = 0x10a0, last = 0x10ff },
   ["阿姆哈拉语"] = { first = 0x1200, last = 0x137f },
   ["希腊语扩展"] = { first = 0x1f00, last = 0x1fff },
   ["类字母符号"] = { first = 0x2100, last = 0x214f },
   ["和卓文"] = { first = 0x11200, last = 0x1124f },
   ["傔容"] = { first = 0x3300, last = 0x33ff },
   ["佉卢文"] = { first = 0x10a00, last = 0x10a5f },
   ["假名扩"] = { first = 0x31f0, last = 0x31ff },
   ["声调修饰符"] = { first = 0xa700, last = 0xa71f },
   ["西夏文"] = { first = 0x17000, last = 0x187ff },
   ["玛钦文"] = { first = 0x11c70, last = 0x11cbf },
   ["数运"] = { first = 0x2200, last = 0x22ff },
   ["片假名"] = { first = 0x30a0, last = 0x30ff },
   ["曼尼普尔语"] = { first = 0xabc0, last = 0xabff },
   ["锡尔赫特文"] = { first = 0xa800, last = 0xa82f },
   ["默禄文"] = { first = 0x16a40, last = 0x16a6f },
   ["变体选择器"] = { first = 0xfe00, last = 0xfe0f },
   ["莫迪文"] = { first = 0x11600, last = 0x1165f },
   ["算筹"] = { first = 0x1d360, last = 0x1d37f },
   ["女书"] = { first = 0x1b170, last = 0x1b2ff },
   ["标签"] = { first = 0xe0000, last = 0xe007f },
   ["古木基文"] = { first = 0x0a00, last = 0x0a7f },
   ["货币符号"] = { first = 0x20a0, last = 0x20cf },
   ["吠陀扩展"] = { first = 0x1cd0, last = 0x1cff },
   ["彝族部首"] = { first = 0xa490, last = 0xa4cf },
   ["箭头"] = { first = 0x2190, last = 0x21ff },
   ["巴塔克语"] = { first = 0x1bc0, last = 0x1bff },
   ["彝族音节"] = { first = 0xa000, last = 0xa48f },
   ["康熙"] = { first = 0x2f00, last = 0x2fdf },
   ["西里尔"] = { first = 0x0400, last = 0x04ff },
   ["希伯来语"] = { first = 0x0590, last = 0x05ff },
   ["阿拉伯语"] = { first = 0x0600, last = 0x06ff },
   ["巴姆穆语"] = { first = 0xa6a0, last = 0xa6ff },
   ["叙利亚文"] = { first = 0x0700, last = 0x074f },
   ["它拿字母"] = { first = 0x0780, last = 0x07bf },
   ["奥里亚语"] = { first = 0x0b00, last = 0x0b7f },
   ["孟加拉语"] = { first = 0x0980, last = 0x09ff },
   ["泰米尔语"] = { first = 0x0b80, last = 0x0bff },
   ["泰卢固语"] = { first = 0x0c00, last = 0x0c7f },
   ["卡纳达语"] = { first = 0x0c80, last = 0x0cff },
   ["僧伽罗语"] = { first = 0x0d80, last = 0x0dff },
   ["韩文字母"] = { first = 0x1100, last = 0x11ff },
   ["切罗基语"] = { first = 0x13a0, last = 0x13ff },
   ["高棉符号"] = { first = 0x19e0, last = 0x19ff },
   ["汉文训读"] = { first = 0x3190, last = 0x319f },
   ["竖排形式"] = { first = 0xfe10, last = 0xfe1f },
   ["特殊字符"] = { first = 0xfff0, last = 0xffff },
   ["八思巴字"] = { first = 0xa840, last = 0xa87f },
   ["德宏傣文"] = { first = 0x1950, last = 0x197f },
   ["科普特文"] = { first = 0x2c80, last = 0x2cff },
   ["克耶字母"] = { first = 0xa900, last = 0xa92f },
   ["装饰"] = { first = 0x2700, last = 0x27bf },
   ["杂项"] = { first = 0x2600, last = 0x26ff },
   ["布希德文"] = { first = 0x1740, last = 0x175f },
   ["哈努诺文"] = { first = 0x1720, last = 0x173f },
   ["几何"] = { first = 0x25a0, last = 0x25ff },
   ["韩文音节"] = { first = 0xac00, last = 0xd7af },
   ["方块元素"] = { first = 0x2580, last = 0x259f },
   ["他加禄语"] = { first = 0x1700, last = 0x171f },
   ["卢恩字母"] = { first = 0x16a0, last = 0x16ff },
   ["控制图片"] = { first = 0x2400, last = 0x243f },
   ["欧甘字母"] = { first = 0x1680, last = 0x169f },
   ["绒巴文"] = { first = 0x1c00, last = 0x1c4f },
   ["拉让语"] = { first = 0xa930, last = 0xa95f },
   ["曼达文"] = { first = 0x0840, last = 0x085f },
   ["巽他语"] = { first = 0x1b80, last = 0x1bbf },
   ["瓦伊语"] = { first = 0xa500, last = 0xa63f },
   ["傣仂语"] = { first = 0x1980, last = 0x19df },
   ["林布语"] = { first = 0x1900, last = 0x194f },
   ["巴厘语"] = { first = 0x1b00, last = 0x1b7f },
   ["蒙古语"] = { first = 0x1800, last = 0x18af },
   ["高棉语"] = { first = 0x1780, last = 0x17ff },
   ["老傣文"] = { first = 0x1a20, last = 0x1aaf },
   ["缅甸语"] = { first = 0x1000, last = 0x109f },
   ["老挝语"] = { first = 0x0e80, last = 0x0eff },
   ["傈僳语"] = { first = 0xa4d0, last = 0xa4ff },
   ["爪哇语"] = { first = 0xa980, last = 0xa9df },
   ["布吉语"] = { first = 0x1a00, last = 0x1a1f },
   ["占语"] = { first = 0xaa00, last = 0xaa5f },
   ["梵文"] = { first = 0x0900, last = 0x097f },
   ["傣文"] = { first = 0xaa80, last = 0xaadf },
   ["注音"] = { first = 0x3100, last = 0x312f },
   ["高位专用替代"] = { first = 0xdb80, last = 0xdbff },
   ["藏文"] = { first = 0x0f00, last = 0x0fff },
   ["泰语"] = { first = 0x0e00, last = 0x0e7f },
   ["盲文"] = { first = 0x2800, last = 0x28ff },
   ["低位替代区"] = { first = 0xdc00, last = 0xdfff },
   ["高位替代区"] = { first = 0xd800, last = 0xdb7f },
   ["Compat"] = { first = 0x2F8000, last = 0x2FA1FF } }

local function exists(single_filter, text)
  for i in utf8.codes(text) do
     local c = utf8.codepoint(text, i)
     if (not single_filter(c)) then
	return false
     end
  end
  return true
end

local function is_charset(s)
   return function (c)
      return c >= charset[s].first and c <= charset[s].last
   end
end

local function is_cjk_ext(c)
   return is_charset("扩A")(c) or is_charset("扩B")(c) or
      is_charset("扩C")(c) or is_charset("扩D")(c) or
      is_charset("扩E")(c) or is_charset("扩F")(c) or
      is_charset("扩G")(c) or is_charset("扩H")(c) or
      is_charset("扩I")(c) or is_charset("拉丁补")(c) or
      is_charset("拉丁语")(c) or is_charset("私用区")(c) or
      is_charset("私用补")(c) or is_charset("符号和象形文字扩展-A")(c) or
      is_charset("中日韩兼容表意文字增补")(c) or is_charset("楔形文字数字和标点符号")(c) or
      is_charset("高加索阿尔巴尼亚语言")(c) or is_charset("统一加拿大原住民音节扩展")(c) or
      is_charset("补私用-A")(c) or is_charset("补充符号和象形文字")(c) or
      is_charset("阿拉伯字母数字符号")(c) or is_charset("杂项符号和象形文字")(c) or
      is_charset("日文假名扩展-A")(c) or is_charset("安纳托利亚象形文字")(c) or
      is_charset("表意符号和标点符号")(c) or is_charset("线形文字B表意文字")(c) or
      is_charset("阿拉伯语表现形式-A")(c) or is_charset("方框绘制字符(制表符)")(c) or
      is_charset("札那巴札尔方形字母")(c) or is_charset("阿拉伯语表现形式-B")(c) or
      is_charset("斐斯托斯圆盘古文字")(c) or is_charset("埃及圣书体格式控制")(c) or
      is_charset("奥斯曼西亚克数字")(c) or is_charset("小型日文假名扩展")(c) or
      is_charset("带圈表意文字补充")(c) or is_charset("带圈字母数字补充")(c) or
      is_charset("格拉哥里字母增补")(c) or is_charset("尼亚坑普阿绰苗文")(c) or
      is_charset("统一加拿大原住民音节")(c) or is_charset("中日韩带圈字符及月份")(c) or
      is_charset("哈乃斐罗兴亚文字")(c) or is_charset("中日韩符号和标点符号")(c) or
      is_charset("阿姆哈拉语扩展-A")(c) or is_charset("马萨拉姆贡德文字")(c) or
      is_charset("变化选择器补充")(c) or is_charset("速记格式控制符")(c) or
      is_charset("追加箭头-C")(c) or is_charset("拜占庭音乐符号")(c) or
      is_charset("交通和地图符号")(c) or is_charset("古希腊音乐记号")(c) or
      is_charset("字母和数字符号")(c) or is_charset("印度西亚格数字")(c) or
      is_charset("结合符号的变音符号")(c) or is_charset("中日韩汉字部首补充")(c) or
      is_charset("古北部阿拉伯语")(c) or is_charset("古南部阿拉伯语")(c) or
      is_charset("麦罗埃文草体字")(c) or is_charset("奥斯曼亚字母")(c) or
      is_charset("塞浦路斯语音节")(c) or is_charset("爱尔巴桑字母")(c) or
      is_charset("德瑟雷特字母")(c) or is_charset("杂项数学符号-A")(c) or
      is_charset("杂项数学符号-B")(c) or is_charset("科普特闰余数字")(c) or
      is_charset("西里尔文扩展-B")(c) or is_charset("西里尔文扩展-A")(c) or
      is_charset("韩文字母扩展-A")(c) or is_charset("中日韩兼容表意文字")(c) or
      is_charset("韩文字母扩展-B")(c) or is_charset("梅德法伊德林文")(c) or
      is_charset("线形文字B音节")(c) or is_charset("巴姆穆文字增补")(c) or
      is_charset("蒙古语增补")(c) or is_charset("古僧伽罗文数字")(c) or
      is_charset("西里尔文扩展-C")(c) or is_charset("麦罗埃象形文字")(c) or
      is_charset("日文假名补充")(c) or is_charset("阿德拉姆字母")(c) or
      is_charset("门德基卡库文")(c) or is_charset("萨顿书写符号")(c) or
      is_charset("几何图形扩展")(c) or is_charset("表意文字描述字符")(c) or
      is_charset("巴尔米拉字母")(c) or is_charset("拉丁语扩展-A")(c) or
      is_charset("乌加里特语")(c) or is_charset("古代楔形文字")(c) or
      is_charset("易经六十四卦符号")(c) or is_charset("萧伯纳字母")(c) or
      is_charset("泰米尔文增补")(c) or is_charset("贡贾拉贡德文")(c) or
      is_charset("拉丁语扩展-B")(c) or is_charset("欧塞奇字母")(c) or
      is_charset("拉丁语扩展-D")(c) or is_charset("希腊语和科普特语")(c) or
      is_charset("结合变音符号扩展")(c) or is_charset("缅甸语扩展-B")(c) or
      is_charset("索拉僧平文字")(c) or is_charset("鲁米数字符号")(c) or
      is_charset("线性文字A")(c) or is_charset("古匈牙利字母")(c) or
      is_charset("阿拉伯语扩展-A")(c) or is_charset("常用印度数字形式")(c) or
      is_charset("诗篇巴列维文")(c) or is_charset("碑刻巴列维文")(c) or
      is_charset("碑刻帕提亚文")(c) or is_charset("阿维斯陀字母")(c) or
      is_charset("结合变音标记增补")(c) or is_charset("帝国阿拉姆語")(c) or
      is_charset("古意大利字母")(c) or is_charset("拉丁语扩展-C")(c) or
      is_charset("缅甸语扩展-A")(c) or is_charset("拉丁文扩展-E")(c) or
      is_charset("多米诺骨牌")(c) or is_charset("太玄经符号")(c) or
      is_charset("炼金术符号")(c) or is_charset("杜普雷速记")(c) or
      is_charset("西夏文部首")(c) or is_charset("拉丁语扩展附加")(c) or
      is_charset("封闭式字母数字")(c) or is_charset("补充箭头-A")(c) or
      is_charset("国际音标扩展")(c) or is_charset("间距修饰字符")(c) or
      is_charset("组合变音标记")(c) or is_charset("补充箭头-B")(c) or
      is_charset("补充数学运算符")(c) or is_charset("其他符号和箭头")(c) or
      is_charset("格鲁吉亚文增补")(c) or is_charset("阿姆哈拉语扩展")(c) or
      is_charset("中日韩汉语笔画")(c) or is_charset("腓尼基字母")(c) or
      is_charset("曼尼普尔语扩展")(c) or is_charset("全角和半角字符")(c) or
      is_charset("爱琴海数字")(c) or is_charset("古希腊数字")(c) or
      is_charset("古罗马符号")(c) or is_charset("卡里亚字母")(c) or
      is_charset("古彼尔姆文")(c) or is_charset("古波斯语")(c) or
      is_charset("纳巴泰字母")(c) or is_charset("中日韩兼容形式")(c) or
      is_charset("哈特兰字母")(c) or is_charset("古代突厥語")(c) or
      is_charset("古粟特字母")(c) or is_charset("以利买字母")(c) or
      is_charset("马哈雅尼文")(c) or is_charset("库达瓦迪文")(c) or
      is_charset("瓦兰齐地文")(c) or is_charset("索永布字母")(c) or
      is_charset("拜克舒基文")(c) or is_charset("埃及圣书体")(c) or
      is_charset("巴萨哇文字")(c) or is_charset("柏格理苗文")(c) or
      is_charset("阿姆哈拉语增补")(c) or is_charset("提尔胡塔文")(c) or
      is_charset("格鲁吉亚文扩展")(c) or is_charset("表情符号")(c) or
      is_charset("玛雅数字")(c) or is_charset("装饰符号")(c) or
      is_charset("音乐符号")(c) or is_charset("象棋符号")(c) or
      is_charset("文乔字母")(c) or is_charset("杂项技术符号")(c) or
      is_charset("数字形式符号")(c) or is_charset("悉昙文字")(c) or
      is_charset("切罗基语增补")(c) or is_charset("西里尔文增补")(c) or
      is_charset("塔克里文")(c) or is_charset("补充标点符号")(c) or
      is_charset("阿洪姆语")(c) or is_charset("小型变体形式")(c) or
      is_charset("阿拉伯语增补")(c) or is_charset("索拉什特拉语")(c) or
      is_charset("西非书面文字")(c) or is_charset("撒玛利亚字母")(c) or
      is_charset("婆罗米文")(c) or is_charset("叙利亚文增补")(c) or
      is_charset("粟特字母")(c) or is_charset("多格拉语")(c) or
      is_charset("桑塔利语字母")(c) or is_charset("南迪城文")(c) or
      is_charset("吕基亚语")(c) or is_charset("包钦豪文")(c) or
      is_charset("光学字符识别")(c) or is_charset("马拉雅拉姆语")(c) or
      is_charset("吕底亚语")(c) or is_charset("望加锡文")(c) or
      is_charset("国际音标扩展")(c) or is_charset("国际音标增补")(c) or
      is_charset("摩尼字母")(c) or is_charset("楔形文字")(c) or
      is_charset("格拉哥里字母")(c) or is_charset("塔格巴努亚文")(c) or
      is_charset("哥特字母")(c) or is_charset("帕哈苗文")(c) or
      is_charset("一般标点符号")(c) or is_charset("注音符号扩展")(c) or
      is_charset("韩文兼容字母")(c) or is_charset("字母连写形式")(c) or
      is_charset("组合用半符号")(c) or is_charset("查克马语")(c) or
      is_charset("夏拉达文")(c) or is_charset("木尔坦文")(c) or
      is_charset("古兰塔文")(c) or is_charset("尼瓦尔语")(c) or
      is_charset("扑克牌")(c) or is_charset("麻将牌")(c) or
      is_charset("凯提文")(c) or is_charset("日文平假名")(c) or
      is_charset("亚美尼亚语")(c) or is_charset("上标和下标")(c) or
      is_charset("提非纳字母")(c) or is_charset("古吉拉特語")(c) or
      is_charset("天城文扩展")(c) or is_charset("巽他文增补")(c) or
      is_charset("格鲁吉亚语")(c) or is_charset("阿姆哈拉语")(c) or
      is_charset("希腊语扩展")(c) or is_charset("类字母符号")(c) or
      is_charset("和卓文")(c) or is_charset("中日韩兼容")(c) or
      is_charset("佉卢文")(c) or is_charset("片假名扩展")(c) or
      is_charset("声调修饰符")(c) or is_charset("西夏文")(c) or
      is_charset("玛钦文")(c) or is_charset("数学运算符")(c) or
      is_charset("日文片假名")(c) or is_charset("曼尼普尔语")(c) or
      is_charset("锡尔赫特文")(c) or is_charset("默禄文")(c) or
      is_charset("变体选择器")(c) or is_charset("莫迪文")(c) or
      is_charset("算筹")(c) or is_charset("女书")(c) or
      is_charset("标签")(c) or is_charset("古木基文")(c) or
      is_charset("货币符号")(c) or is_charset("吠陀扩展")(c) or
      is_charset("彝族部首")(c) or is_charset("箭头符号")(c) or
      is_charset("巴塔克语")(c) or is_charset("彝族音节")(c) or
      is_charset("康熙部首")(c) or is_charset("西里尔文")(c) or
      is_charset("希伯来语")(c) or is_charset("阿拉伯语")(c) or
      is_charset("巴姆穆语")(c) or is_charset("叙利亚文")(c) or
      is_charset("它拿字母")(c) or is_charset("奥里亚语")(c) or
      is_charset("孟加拉语")(c) or is_charset("泰米尔语")(c) or
      is_charset("泰卢固语")(c) or is_charset("卡纳达语")(c) or
      is_charset("僧伽罗语")(c) or is_charset("韩文字母")(c) or
      is_charset("切罗基语")(c) or is_charset("高棉符号")(c) or
      is_charset("汉文训读")(c) or is_charset("竖排形式")(c) or
      is_charset("特殊字符")(c) or is_charset("八思巴字")(c) or
      is_charset("德宏傣文")(c) or is_charset("科普特文")(c) or
      is_charset("克耶字母")(c) or is_charset("装饰符号")(c) or
      is_charset("杂项符号")(c) or is_charset("布希德文")(c) or
      is_charset("哈努诺文")(c) or is_charset("几何形状")(c) or
      is_charset("韩文音节")(c) or is_charset("方块元素")(c) or
      is_charset("他加禄语")(c) or is_charset("卢恩字母")(c) or
      is_charset("控制图片")(c) or is_charset("欧甘字母")(c) or
      is_charset("绒巴文")(c) or is_charset("拉让语")(c) or
      is_charset("曼达文")(c) or is_charset("巽他语")(c) or
      is_charset("瓦伊语")(c) or is_charset("傣仂语")(c) or
      is_charset("林布语")(c) or is_charset("巴厘语")(c) or
      is_charset("蒙古语")(c) or is_charset("高棉语")(c) or
      is_charset("老傣文")(c) or is_charset("缅甸语")(c) or
      is_charset("老挝语")(c) or is_charset("傈僳语")(c) or
      is_charset("爪哇语")(c) or is_charset("布吉语")(c) or
      is_charset("占语")(c) or is_charset("梵文")(c) or
      is_charset("傣文")(c) or is_charset("注音")(c) or
      is_charset("高位专用替代")(c) or is_charset("藏文")(c) or
      is_charset("泰语")(c) or is_charset("盲文")(c) or
      is_charset("低位替代区")(c) or is_charset("高位替代区")(c) or
      is_charset("Compat")(c)
end

local function charset_filter(input)
   for cand in input:iter() do
      if (not exists(is_cjk_ext, cand.text))
      then
	 yield(cand)
      end
   end
end


--- charset comment filter
local function charset_comment_filter(input,env)
  local b = env.engine.context:get_option("charset_comment_filter")--开关状态
  for cand in input:iter() do
    if b then
     for s, r in pairs(charset) do
       if (exists(is_charset(s), cand.text)) then
         cand:get_genuine().comment = cand.comment .. " " .. s
         break
       end--if
      end--for
     end--if
      yield(cand)
   end
end


return charset_comment_filter


