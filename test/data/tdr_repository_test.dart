import 'dart:io';

import 'package:grandis/data/model/item.dart';
import 'package:grandis/data/model/park_type.dart';
import 'package:grandis/data/repository/tdr_repository.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tdlAttractionRes = '''
[
    {
        "FacilityID": "173",
        "FacilityName": "アリスのティーパーティー",
        "FacilityKanaName": "ｱﾘｽのﾃｨｰﾊﾟｰﾃｨｰ",
        "NewFlg": false,
        "FacilityURLSP": "http://www.tokyodisneyresort.jp/sp/attraction/detail/str_id:fl_alice/",
        "FacilityStatusCD": null,
        "FacilityStatus": null,
        "StandbyTime": "10",
        "OperatingHoursFromDate": "20190827",
        "OperatingHoursFrom": "8:00",
        "OperatingHoursToDate": "20190827",
        "OperatingHoursTo": "22:00",
        "OperatingStatusCD": "001",
        "OperatingStatus": "運営中",
        "SunsetFlg": false,
        "Fsflg": false,
        "FsStatusflg": null,
        "FsStatus": null,
        "FsStatusCD": null,
        "FsStatusStartDate": null,
        "FsStatusStartTime": null,
        "FsStatusEndDate": null,
        "FsStatusEndTime": null,
        "UseLimitFlg": false,
        "UseStandbyTimeStyle": true,
        "OperatingChgFlg": false,
        "UpdateTime": "17:10",
        "operatingHours": [
            {
                "OperatingHoursFromDate": "20190827",
                "OperatingHoursFrom": "8:00",
                "OperatingHoursToDate": "20190827",
                "OperatingHoursTo": "22:00",
                "SunsetFlg": false,
                "OperatingStatusCD": "001",
                "OperatingStatus": "運営中",
                "OperatingChgFlg": false
            }
        ]
    }
]
''';
  final tdsAttractionRes = '''
[
    {
        "FacilityID": "234",
        "FacilityName": "アクアトピア",
        "FacilityKanaName": "ｱｸｱﾄﾋﾟｱ",
        "NewFlg": false,
        "FacilityURLSP": "http://www.tokyodisneyresort.jp/sp/attraction/detail/str_id:pd_aqua/",
        "FacilityStatusCD": null,
        "FacilityStatus": null,
        "StandbyTime": "10",
        "OperatingHoursFromDate": "20190827",
        "OperatingHoursFrom": "8:00",
        "OperatingHoursToDate": "20190827",
        "OperatingHoursTo": "22:00",
        "OperatingStatusCD": "001",
        "OperatingStatus": "運営中",
        "SunsetFlg": false,
        "Fsflg": false,
        "FsStatusflg": null,
        "FsStatus": null,
        "FsStatusCD": null,
        "FsStatusStartDate": null,
        "FsStatusStartTime": null,
        "FsStatusEndDate": null,
        "FsStatusEndTime": null,
        "UseLimitFlg": true,
        "UseStandbyTimeStyle": true,
        "OperatingChgFlg": false,
        "UpdateTime": "18:56",
        "operatingHours": [
            {
                "OperatingHoursFromDate": "20190827",
                "OperatingHoursFrom": "8:00",
                "OperatingHoursToDate": "20190827",
                "OperatingHoursTo": "22:00",
                "SunsetFlg": false,
                "OperatingStatusCD": "001",
                "OperatingStatus": "運営中",
                "OperatingChgFlg": false
            }
        ]
    }
]
''';
  final tdlParadeRes = '''
[
    {
        "FacilityID": "913",
        "FacilityName": "東京ディズニーランド・エレクトリカルパレード・ドリームライツ",
        "FacilityKanaName": "東京ﾃﾞｨｽﾞﾆｰﾗﾝﾄﾞ･ｴﾚｸﾄﾘｶﾙﾊﾟﾚｰﾄﾞ･ﾄﾞﾘｰﾑﾗｲﾂ",
        "NewFlg": false,
        "AreaJName": "パレードルート（パークワイド）",
        "AreaMName": "ﾊﾟﾚｰﾄﾞﾙｰﾄ（ﾊﾟｰｸﾜｲﾄﾞ）",
        "FacilityURLSP": "http://www.tokyodisneyresort.jp/sp/show/detail/str_id:pw_dreamlights/",
        "FacilityStatusCD": null,
        "FacilityStatus": null,
        "operatingHours": [
            {
                "OperatingHoursFromDate": "20190827",
                "OperatingHoursFrom": "20:00",
                "OperatingHoursToDate": null,
                "OperatingHoursTo": null,
                "LotteryFlg": false,
                "SunsetFlg": false,
                "OperatingStatusCD": "014",
                "OperatingStatus": "公演中止（ミニパレード「ナイトフォール・グロウ」を公演）",
                "OperatingChgFlg": false,
                "ShowLineCutStatusCD": "0"
            }
        ],
        "UpdateTime": "19:25"
    }
]
''';
  final tdsParadeRes = '''
[
    {
        "FacilityID": "929",
        "FacilityName": "ファンタズミック！",
        "FacilityKanaName": "ﾌｧﾝﾀｽﾞﾐｯｸ!",
        "NewFlg": false,
        "AreaJName": "メディテレーニアンハーバー",
        "AreaMName": "ﾒﾃﾞｨﾃﾚｰﾆｱﾝﾊｰﾊﾞｰ",
        "FacilityURLSP": "http://www.tokyodisneyresort.jp/sp/show/detail/str_id:mh_fantasmic/",
        "FacilityStatusCD": null,
        "FacilityStatus": null,
        "operatingHours": [
            {
                "OperatingHoursFromDate": "20190827",
                "OperatingHoursFrom": "20:05",
                "OperatingHoursToDate": null,
                "OperatingHoursTo": null,
                "LotteryFlg": false,
                "SunsetFlg": false,
                "OperatingStatusCD": null,
                "OperatingStatus": null,
                "OperatingChgFlg": false,
                "ShowLineCutStatusCD": "0"
            }
        ],
        "UpdateTime": "8:00"
    }
]
''';
  final tdlGreetingRes = '''
{
    "id11": {
        "AreaJName": "ワールドバザール",
        "AreaMName": "ﾜｰﾙﾄﾞﾊﾞｻﾞｰﾙ",
        "Facility": [
            {
                "greeting": {
                    "FacilityID": "907",
                    "FacilityName": "ベビーカー＆車イス・レンタル側",
                    "FacilityKanaName": "ﾍﾞﾋﾞｰｶｰ&車ｲｽ･ﾚﾝﾀﾙ側",
                    "NewFlg": false,
                    "AreaJName": "ワールドバザール",
                    "AreaMName": "ﾜｰﾙﾄﾞﾊﾞｻﾞｰﾙ",
                    "FacilityURLSP": "http://www.tokyodisneyresort.jp/sp/greeting/detail/str_id:gre_rental/",
                    "FacilityStatusCD": "003",
                    "FacilityStatus": "運営・公演中止",
                    "StandbyTime": null,
                    "operatinghours": null,
                    "UseStandbyTimeStyle": false,
                    "UpdateTime": "8:00"
                }
            }
        ]
    },
    "id13": {
        "AreaJName": "ウエスタンランド",
        "AreaMName": "ｳｴｽﾀﾝﾗﾝﾄﾞ",
        "Facility": [
            {
                "greeting": {
                    "FacilityID": "917",
                    "FacilityName": "ウッドチャック・グリーティングトレイル（デイジー）",
                    "FacilityKanaName": "ｳｯﾄﾞﾁｬｯｸ･ｸﾞﾘｰﾃｨﾝｸﾞﾄﾚｲﾙ（ﾃﾞｲｼﾞｰ）",
                    "NewFlg": false,
                    "AreaJName": "ウエスタンランド",
                    "AreaMName": "ｳｴｽﾀﾝﾗﾝﾄﾞ",
                    "FacilityURLSP": "http://www.tokyodisneyresort.jp/sp/greeting/detail/str_id:camp_trail_daisy/",
                    "FacilityStatusCD": null,
                    "FacilityStatus": null,
                    "StandbyTime": "35",
                    "operatinghours": [
                        {
                            "OperatingHoursFromDate": "20190827",
                            "OperatingHoursFrom": "8:00",
                            "OperatingHoursToDate": "20190827",
                            "OperatingHoursTo": "22:00",
                            "OperatingStatusCD": "001",
                            "OperatingStatus": "運営中",
                            "OperatingChgFlg": false,
                            "SunsetFlg": false
                        }
                    ],
                    "UseStandbyTimeStyle": true,
                    "UpdateTime": "18:21"
                }
            }
        ]
    },
    "id16": {
        "AreaJName": "トゥーンタウン",
        "AreaMName": "ﾄｩｰﾝﾀｳﾝ",
        "Facility": [
            {
                "greeting": {
                    "FacilityID": "909",
                    "FacilityName": "ミッキーの家とミート・ミッキー",
                    "FacilityKanaName": "ﾐｯｷｰの家とﾐｰﾄ･ﾐｯｷｰ",
                    "NewFlg": false,
                    "AreaJName": "トゥーンタウン",
                    "AreaMName": "ﾄｩｰﾝﾀｳﾝ",
                    "FacilityURLSP": "http://www.tokyodisneyresort.jp/sp/greeting/detail/str_id:tt_mickey/",
                    "FacilityStatusCD": null,
                    "FacilityStatus": null,
                    "StandbyTime": "40",
                    "operatinghours": [
                        {
                            "OperatingHoursFromDate": "20190827",
                            "OperatingHoursFrom": "8:00",
                            "OperatingHoursToDate": "20190827",
                            "OperatingHoursTo": "22:00",
                            "OperatingStatusCD": "001",
                            "OperatingStatus": "運営中",
                            "OperatingChgFlg": false,
                            "SunsetFlg": false
                        }
                    ],
                    "UseStandbyTimeStyle": true,
                    "UpdateTime": "19:05"
                }
            }
        ]
    }
}
''';
  final tdsGreetingRes = '''
{
    "id21": {
        "AreaJName": "メディテレーニアンハーバー",
        "AreaMName": "ﾒﾃﾞｨﾃﾚｰﾆｱﾝﾊｰﾊﾞｰ",
        "Facility": [
            {
                "greeting": {
                    "FacilityID": "921",
                    "FacilityName": "ディズニーシー・プラザ（ヴァレンティーナズ・スウィート側）",
                    "FacilityKanaName": "ﾃﾞｨｽﾞﾆｰｼｰ･ﾌﾟﾗｻﾞ(ｳﾞｧﾚﾝﾃｨｰﾅｽﾞ･ｽｳｨｰﾄ側)",
                    "NewFlg": false,
                    "AreaJName": "メディテレーニアンハーバー",
                    "AreaMName": "ﾒﾃﾞｨﾃﾚｰﾆｱﾝﾊｰﾊﾞｰ",
                    "FacilityURLSP": "http://www.tokyodisneyresort.jp/sp/greeting/detail/str_id:gre_plaza/",
                    "FacilityStatusCD": null,
                    "FacilityStatus": null,
                    "StandbyTime": null,
                    "operatinghours": [
                        {
                            "OperatingHoursFromDate": "20190827",
                            "OperatingHoursFrom": "8:40",
                            "OperatingHoursToDate": "20190827",
                            "OperatingHoursTo": "10:40",
                            "OperatingStatusCD": "002",
                            "OperatingStatus": "案内終了",
                            "OperatingChgFlg": false,
                            "SunsetFlg": false
                        },
                        {
                            "OperatingHoursFromDate": "20190827",
                            "OperatingHoursFrom": "11:50",
                            "OperatingHoursToDate": "20190827",
                            "OperatingHoursTo": "13:10",
                            "OperatingStatusCD": "002",
                            "OperatingStatus": "案内終了",
                            "OperatingChgFlg": false,
                            "SunsetFlg": false
                        },
                        {
                            "OperatingHoursFromDate": "20190827",
                            "OperatingHoursFrom": "13:50",
                            "OperatingHoursToDate": "20190827",
                            "OperatingHoursTo": "15:50",
                            "OperatingStatusCD": "002",
                            "OperatingStatus": "案内終了",
                            "OperatingChgFlg": false,
                            "SunsetFlg": false
                        }
                    ],
                    "UseStandbyTimeStyle": false,
                    "UpdateTime": "15:16"
                }
            }
        ]
    },
    "id22": {
        "AreaJName": "アメリカンウォーターフロント",
        "AreaMName": "ｱﾒﾘｶﾝｳｫｰﾀｰﾌﾛﾝﾄ",
        "Facility": [
            {
                "greeting": {
                    "FacilityID": "905",
                    "FacilityName": "ヴィレッジ・グリーティングプレイス",
                    "FacilityKanaName": "ｳﾞｨﾚｯｼﾞ･ｸﾞﾘｰﾃｨﾝｸﾞﾌﾟﾚｲｽ",
                    "NewFlg": false,
                    "AreaJName": "アメリカンウォーターフロント",
                    "AreaMName": "ｱﾒﾘｶﾝｳｫｰﾀｰﾌﾛﾝﾄ",
                    "FacilityURLSP": "http://www.tokyodisneyresort.jp/sp/greeting/detail/str_id:aw_greeting/",
                    "FacilityStatusCD": null,
                    "FacilityStatus": null,
                    "StandbyTime": null,
                    "operatinghours": [
                        {
                            "OperatingHoursFromDate": "20190827",
                            "OperatingHoursFrom": "8:00",
                            "OperatingHoursToDate": "20190827",
                            "OperatingHoursTo": "21:00",
                            "OperatingStatusCD": "002",
                            "OperatingStatus": "案内終了",
                            "OperatingChgFlg": false,
                            "SunsetFlg": false
                        }
                    ],
                    "UseStandbyTimeStyle": false,
                    "UpdateTime": "19:57"
                }
            }
        ]
    },
    "id25": {
        "AreaJName": "ロストリバーデルタ",
        "AreaMName": "ﾛｽﾄﾘﾊﾞｰﾃﾞﾙﾀ",
        "Facility": [
            {
                "greeting": {
                    "FacilityID": "904",
                    "FacilityName": "“サルードス・アミーゴス！”グリーティングドック",
                    "FacilityKanaName": "“ｻﾙｰﾄﾞｽ･ｱﾐｰｺﾞｽ!ｸﾞﾘｰﾃｨﾝｸﾞﾄﾞｯｸ",
                    "NewFlg": false,
                    "AreaJName": "ロストリバーデルタ",
                    "AreaMName": "ﾛｽﾄﾘﾊﾞｰﾃﾞﾙﾀ",
                    "FacilityURLSP": "http://www.tokyodisneyresort.jp/sp/greeting/detail/str_id:ld_saludos/",
                    "FacilityStatusCD": null,
                    "FacilityStatus": null,
                    "StandbyTime": "35",
                    "operatinghours": [
                        {
                            "OperatingHoursFromDate": "20190827",
                            "OperatingHoursFrom": "8:15",
                            "OperatingHoursToDate": "20190827",
                            "OperatingHoursTo": "21:15",
                            "OperatingStatusCD": "001",
                            "OperatingStatus": "運営中",
                            "OperatingChgFlg": false,
                            "SunsetFlg": false
                        }
                    ],
                    "UseStandbyTimeStyle": true,
                    "UpdateTime": "20:25"
                }
            }
        ]
    },
    "id26": {
        "AreaJName": "マーメイドラグーン",
        "AreaMName": "ﾏｰﾒｲﾄﾞﾗｸﾞｰﾝ",
        "Facility": [
            {
                "greeting": {
                    "FacilityID": "906",
                    "FacilityName": "アリエルのグリーティンググロット",
                    "FacilityKanaName": "ｱﾘｴﾙのｸﾞﾘｰﾃｨﾝｸﾞｸﾞﾛｯﾄ",
                    "NewFlg": false,
                    "AreaJName": "マーメイドラグーン",
                    "AreaMName": "ﾏｰﾒｲﾄﾞﾗｸﾞｰﾝ",
                    "FacilityURLSP": "http://www.tokyodisneyresort.jp/sp/greeting/detail/str_id:ml_greeting/",
                    "FacilityStatusCD": null,
                    "FacilityStatus": null,
                    "StandbyTime": null,
                    "operatinghours": [
                        {
                            "OperatingHoursFromDate": "20190827",
                            "OperatingHoursFrom": "9:30",
                            "OperatingHoursToDate": "20190827",
                            "OperatingHoursTo": "18:00",
                            "OperatingStatusCD": "002",
                            "OperatingStatus": "案内終了",
                            "OperatingChgFlg": false,
                            "SunsetFlg": false
                        }
                    ],
                    "UseStandbyTimeStyle": false,
                    "UpdateTime": "17:25"
                }
            }
        ]
    },
    "id27": {
        "AreaJName": "アラビアンコースト",
        "AreaMName": "ｱﾗﾋﾞｱﾝｺｰｽﾄ",
        "Facility": [
            {
                "greeting": {
                    "FacilityID": "923",
                    "FacilityName": "アラビアンコースト",
                    "FacilityKanaName": "ｱﾗﾋﾞｱﾝｺｰｽﾄ",
                    "NewFlg": false,
                    "AreaJName": "アラビアンコースト",
                    "AreaMName": "ｱﾗﾋﾞｱﾝｺｰｽﾄ",
                    "FacilityURLSP": "http://www.tokyodisneyresort.jp/sp/greeting/detail/str_id:gre_arabian/",
                    "FacilityStatusCD": "003",
                    "FacilityStatus": "運営・公演中止",
                    "StandbyTime": null,
                    "operatinghours": null,
                    "UseStandbyTimeStyle": false,
                    "UpdateTime": "8:00"
                }
            }
        ]
    }
}
''';
  final tdlRestaurantRes = '''
[
    {
        "FacilityID": "313",
        "FacilityName": "れすとらん北齋",
        "FacilityKanaName": "れすとらん北齋",
        "NewFlg": false,
        "FacilityURLSP": "http://www.tokyodisneyresort.jp/sp/restaurant/detail/str_id:JRH/",
        "FacilityStatusCD": null,
        "FacilityStatus": null,
        "StandbyTimeDispFlag": true,
        "StandbyTimeMin": "20",
        "StandbyTimeMax": "20",
        "RestaurantForm": "TS",
        "UseStandbyTimeStyle": true,
        "operatingHours": [
            {
                "OperatingHoursFromDate": "20190827",
                "OperatingHoursFrom": "10:15",
                "OperatingHoursToDate": "20190827",
                "OperatingHoursTo": "21:00",
                "SunsetFlg": false,
                "OperatingStatusCD": "001",
                "OperatingStatus": "運営中",
                "OperatingChgFlg": false
            }
        ],
        "UpdateTime": "20:08",
        "PopCornFlavors": null
    }
]
''';
  final tdsRestaurantRes = '''
[
    {
        "FacilityID": "425",
        "FacilityName": "S.S.コロンビア・ダイニングルーム",
        "FacilityKanaName": "S.S.ｺﾛﾝﾋﾞｱ･ﾀﾞｲﾆﾝｸﾞﾙｰﾑ",
        "NewFlg": false,
        "FacilityURLSP": "http://www.tokyodisneyresort.jp/sp/restaurant/detail/str_id:SSD/",
        "FacilityStatusCD": null,
        "FacilityStatus": null,
        "StandbyTimeDispFlag": null,
        "StandbyTimeMin": null,
        "StandbyTimeMax": null,
        "RestaurantForm": "TS",
        "UseStandbyTimeStyle": false,
        "operatingHours": [
            {
                "OperatingHoursFromDate": "20190827",
                "OperatingHoursFrom": "11:00",
                "OperatingHoursToDate": "20190827",
                "OperatingHoursTo": "20:15",
                "SunsetFlg": false,
                "OperatingStatusCD": "002",
                "OperatingStatus": "案内終了",
                "OperatingChgFlg": false
            }
        ],
        "UpdateTime": "20:16",
        "PopCornFlavors": null
    }
]
''';
  final tdlRehabilitateRes = '''
<div class="linkList linkList33">
  <ul>
    <li>
      <a href="/tdl/attraction/detail/155/">
        <img src="https://media1.tokyodisneyresort.jp/images/adventure/attraction/271_thum_name.jpg?mod=20230131122152" alt="">
        <div class="listTextArea">
        <p class="heading3">スイスファミリー・ツリーハウス</p>
        <p>
2022/4/1
- 未定
        </p>
        </div>
      </a>
    </li>
  </ul>
</dev>
''';
  final tdsRehabilitateRes = '''
<div class="linkList linkList33">
  <ul>
    <li>
      <a href="/tds/attraction/detail/221/">
        <img src="https://media1.tokyodisneyresort.jp/images/adventure/attraction/361_thum_name.jpg?mod=20230131122305" alt="">
        <div class="listTextArea">
          <p class="heading3">マーメイドラグーンシアター</p>
          <p>
2020/7/1
- 未定
          </p>
        </div>
      </a>
    </li>
  </ul>
</dev>
''';
  final tdlStatusRes = '''
<div class="state-left">
    <div class="texArea">
      <dl>
        <dt style="width: 128px;">本日の開園時間</dt>
                  <dd style="width: 145px;">
                                9:00 - 21:00                 </dd>
              </dl>
              <dl>
        <dt style="width: 128px;">チケット販売状況</dt>
        <dd class="remaining is-soldout sun" style="width: 145px;">
          売り切れ
                  </dd>
      </dl>
            </div>
        <div class="weather-icon">
      <img src="https://media2.tokyodisneyresort.jp/weather/icon_svg/weather_icon100.svg">
    </div>
</div>
''';
  final tdsStatusRes = '''
<div class="state-left">
    <div class="texArea">
      <dl>
        <dt style="width: 128px;">本日の開園時間</dt>
                  <dd style="width: 145px;">
                                9:00 - 21:00                 </dd>
              </dl>
              <dl>
        <dt style="width: 128px;">チケット販売状況</dt>
        <dd class="remaining is-notSales " style="width: 145px;">
          販売なし
                  </dd>
      </dl>
            </div>
        <div class="weather-icon">
      <img src="https://media2.tokyodisneyresort.jp/weather/icon_svg/weather_icon100.svg">
    </div>
</div>
''';
  final newGoodsRes = '''
<body>
  <div class="linkList13">
    <ul class="list-block">
      <li>
        <a href="/goods/123013558/">
          <div class="imgarea">
            <div class="maskSquare">
              <img src="https://media1.tokyodisneyresort.jp/images/adventure/goods/60e3f3ec44439_1.jpg?mod=20211105100003" alt="くっつきぬいぐるみのイメージ">
            </div>
          </div>
          <div class="columnText mt10">
            <p class="linkText"><span>くっつきぬいぐるみ</span><span class="new">NEW</span></p>
            <p class="price">￥1,800</p>
          </div>
        </a>
      </li>
    </ul>
  </div>
  <div class="button-block center">
    <div class="button mt0"><a href="javascript:void(0)" class="more" data-count="48" data-tags="">ウェブサイトでもっと見る</a></div>
    </div>
  <div class="button-block center">
    <div class="button mt0"><a href="https://share.shopping.tokyodisneyresort.jp/landing/landing.html?start=1">
      アプリですべてのグッズを見る</a>
    </div>
  </div>
</body>
''';
  final soonGoodsRes = '''
<html>
  <head></head>
  <body>
    <div class="linkList13">
      <ul class="list-block">
        <li>
          <a href="/goods/115000668/">
            <div class="imgarea">
              <div class="maskSquare">
                <img src="https://media1.tokyodisneyresort.jp/images/adventure/goods/612847884d621_1.jpg?mod=20211105100003" alt="キーチェーンのイメージ">
              </div>
            </div>
            <div class="columnText mt10">
              <p class="linkText"><span>キーチェーン</span></p>
              <p class="price">￥1,200</p>
              <p>2021年11月18日より販売開始</p>
            </div>
          </a>
        </li>
      </ul>
    </div>
  </body>
</html>
''';

  group('TdrRepository Test', () {
    test('tdl attraction', () async {
      final mockClient = MockClient((_) async {
        return Response(tdlAttractionRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      });
      final actual =
          await TdrRepository(client: mockClient).getAttraction(ParkType.TDL);
      expect(actual, isInstanceOf<List<Item>>());
      expect(actual[0].getTitle(), 'アリスのティーパーティー');
    });

    test('tds attraction', () async {
      final mockClient = MockClient((_) async {
        return Response(tdsAttractionRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      });
      final actual =
          await TdrRepository(client: mockClient).getAttraction(ParkType.TDS);
      expect(actual, isInstanceOf<List<Item>>());
      expect(actual[0].getTitle(), 'アクアトピア');
    });

    test('tdl parade', () async {
      final mockClient = MockClient((_) async {
        return Response(tdlParadeRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      });
      final actual =
          await TdrRepository(client: mockClient).getParade(ParkType.TDL);
      expect(actual, isInstanceOf<List<Item>>());
      expect(actual[0].getTitle(), '東京ディズニーランド・エレクトリカルパレード・ドリームライツ');
    });

    test('tds parade', () async {
      final mockClient = MockClient((_) async {
        return Response(tdsParadeRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      });
      final actual =
          await TdrRepository(client: mockClient).getParade(ParkType.TDS);
      expect(actual, isInstanceOf<List<Item>>());
      expect(actual[0].getTitle(), 'ファンタズミック！');
    });

    test('tdl greeting', () async {
      final mockClient = MockClient((_) async {
        return Response(tdlGreetingRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      });
      final actual =
          await TdrRepository(client: mockClient).getGreeting(ParkType.TDL);
      expect(actual, isInstanceOf<List<Item>>());
      expect(actual[0].getTitle(), 'ベビーカー＆車イス・レンタル側');
    });

    test('tds greeting', () async {
      final mockClient = MockClient((_) async {
        return Response(tdsGreetingRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      });
      final actual =
          await TdrRepository(client: mockClient).getGreeting(ParkType.TDS);
      expect(actual, isInstanceOf<List<Item>>());
      expect(actual[0].getTitle(), 'ディズニーシー・プラザ（ヴァレンティーナズ・スウィート側）');
    });

    test('tdl restaurant', () async {
      final mockClient = MockClient((_) async {
        return Response(tdlRestaurantRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      });
      final actual =
          await TdrRepository(client: mockClient).getRestaurant(ParkType.TDL);
      expect(actual, isInstanceOf<List<Item>>());
      expect(actual[0].getTitle(), 'れすとらん北齋');
    });

    test('tds restaurant', () async {
      final mockClient = MockClient((_) async {
        return Response(tdsRestaurantRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      });
      final actual =
          await TdrRepository(client: mockClient).getRestaurant(ParkType.TDS);
      expect(actual, isInstanceOf<List<Item>>());
      expect(actual[0].getTitle(), 'S.S.コロンビア・ダイニングルーム');
    });

    test('tdl rehabilitate', () async {
      final mockClient = MockClient((_) async {
        return Response(tdlRehabilitateRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      });
      final actual =
          await TdrRepository(client: mockClient).getRehabilitate(ParkType.TDL);
      expect(actual, isInstanceOf<List<Item>>());
      expect(actual[0].getTitle(), 'スイスファミリー・ツリーハウス');
    });

    test('tds rehabilitate', () async {
      final mockClient = MockClient((_) async {
        return Response(tdsRehabilitateRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      });
      final actual =
          await TdrRepository(client: mockClient).getRehabilitate(ParkType.TDL);
      expect(actual, isInstanceOf<List<Item>>());
      expect(actual[0].getTitle(), 'マーメイドラグーンシアター');
    });

    test('tdl status', () async {
      final mockClient = MockClient((_) async {
        return Response(tdlStatusRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      });
      final actual =
          await TdrRepository(client: mockClient).getStatus(ParkType.TDL);
      expect(actual, isInstanceOf<String>());
      expect(actual, '本日の開園時間: 9:00 - 21:00\nチケット販売状況: 売り切れ');
    });

    test('tds status', () async {
      final mockClient = MockClient((_) async {
        return Response(tdsStatusRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      });
      final actual =
          await TdrRepository(client: mockClient).getStatus(ParkType.TDS);
      expect(actual, isInstanceOf<String>());
      expect(actual, '本日の開園時間: 9:00 - 21:00\nチケット販売状況: 販売なし');
    });

    test('tdl new', () async {
      final mockClient = MockClient((_) async {
        return Response(newGoodsRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      });
      final actual =
          await TdrRepository(client: mockClient).getNewGoods(ParkType.TDL);
      expect(actual, isInstanceOf<List<Item>>());
      expect(actual[0].getTitle(), 'くっつきぬいぐるみ');
    });

    test('tds new', () async {
      final mockClient = MockClient((_) async {
        return Response(newGoodsRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      });
      final actual =
          await TdrRepository(client: mockClient).getNewGoods(ParkType.TDS);
      expect(actual, isInstanceOf<List<Item>>());
      expect(actual[0].getTitle(), 'くっつきぬいぐるみ');
    });

    test('tdl soon', () async {
      final mockClient = MockClient((_) async {
        return Response(soonGoodsRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      });
      final actual =
          await TdrRepository(client: mockClient).getSoon(ParkType.TDL);
      expect(actual, isInstanceOf<List<Item>>());
      expect(actual[0].getTitle(), 'キーチェーン');
    });

    test('tds soon', () async {
      final mockClient = MockClient((_) async {
        return Response(soonGoodsRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      });
      final actual =
          await TdrRepository(client: mockClient).getSoon(ParkType.TDS);
      expect(actual, isInstanceOf<List<Item>>());
      expect(actual[0].getTitle(), 'キーチェーン');
    });
  });
}
