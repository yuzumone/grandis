import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:grandis/api.dart';
import 'package:grandis/model.dart';

class MockClient extends Mock implements http.Client {}

final String tdlAttractionRes = """
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
""";
final String tdsAttractionRes = """
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
""";
final String tdlParadeRes = """
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
""";
final String tdsParadeRes = """
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
""";
final String tdlGreetingRes = """
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
""";
final String tdsGreetingRes = """
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
    "id24": {
        "AreaJName": "ポートディスカバリー",
        "AreaMName": "ﾎﾟｰﾄﾃﾞｨｽｶﾊﾞﾘｰ",
        "Facility": [
            {
                "characterDining": {
                    "FacilityID": "452",
                    "FacilityName": "ホライズンベイ・レストラン（キャラクターダイニング）",
                    "FacilityKanaName": "ﾎﾗｲｽﾞﾝﾍﾞｲ･ﾚｽﾄﾗﾝ(ｷｬﾗｸﾀｰﾀﾞｲﾆﾝｸﾞ)",
                    "NewFlg": false,
                    "AreaJName": "ポートディスカバリー",
                    "AreaMName": "ﾎﾟｰﾄﾃﾞｨｽｶﾊﾞﾘｰ",
                    "FacilityURLSP": "http://www.tokyodisneyresort.jp/sp/greeting/detail/str_id:pd_horizon/",
                    "FacilityStatusCD": null,
                    "FacilityStatus": null,
                    "StandbyTime": false,
                    "operatinghours": null,
                    "UseStandbyTimeStyle": false,
                    "UpdateTime": "8:00"
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
                    "FacilityKanaName": "“ｻﾙｰﾄﾞｽ･ｱﾐｰｺﾞｽ!\"ｸﾞﾘｰﾃｨﾝｸﾞﾄﾞｯｸ",
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
""";
final String tdlRestaurantRes = """
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
        "PopCornFlavors": null,
    }
]
""";
final String tdsRestaurantRes = """
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
        "PopCornFlavors": null,
    }
]
""";
final String tdlRehabilitateRes = """
<div class="linkList6">
  <ul>
    <li><a href="/tdl/attraction/detail/154/"><span>
    <p>ウエスタンリバー鉄道</p><p class="date">2019/5/7 - 2019/9/3<br></p>
    </span></a></li>
  </ul>
</div>
""";
final String tdsRehabilitateRes = """
<div class="linkList6">
  <ul>
    <li><a href="/tds/attraction/detail/223/"><span>
    <p>センター・オブ・ジ・アース</p>
    <p class="date">2019/9/2 - 2019/11/30<br></p>
    </span></a></li>
  </ul>
</div>
""";
final String tdlStatusRes = """
<div class="section-noborder">
  <h3 class="heading3">当日券販売状況</h3>
  <p>ただいま東京ディズニーランドは、当日券の販売を行っております。</p>
</div>
""";
final String tdsStatusRes = """
<div class="section-noborder">
  <h3 class="heading3">当日券販売状況</h3>
  <p>ただいま東京ディズニーシーは、当日券の販売を行っております。</p>
</div>
""";

main() {
  group('attractionTest', () {
    test('tdl attraction success', () async {
      final client = MockClient();
      when(client.get(tdsAttractionUrl, headers: requestHeaders))
          .thenAnswer((_) async => http.Response(tdlAttractionRes, 200));
      var result = await getTdlAttraction();
      var expected = Attraction.fromMap({
        'FacilityName': 'アリスのティーパーティー',
        'FacilityURLSP':
            'http://www.tokyodisneyresort.jp/sp/attraction/detail/str_id:fl_alice/',
        'StandbyTime': '10',
        'OperatingStatus': '運営中',
        'UpdateTime': '17:10',
        'FsStatus': null,
      });
      expect(result, isInstanceOf<List<Item>>());
      expect(result.first.toString(), expected.toString());
    });
    test('tds attraction success', () async {
      final client = MockClient();
      when(client.get(tdsAttractionUrl, headers: requestHeaders))
          .thenAnswer((_) async => http.Response(tdsAttractionRes, 200));
      var result = await getTdsAttraction();
      var expected = Attraction.fromMap({
        'FacilityName': 'アクアトピア',
        'FacilityURLSP':
            'http://www.tokyodisneyresort.jp/sp/attraction/detail/str_id:pd_aqua/',
        'StandbyTime': '10',
        'OperatingStatus': '運営中',
        'UpdateTime': '18:56',
        'FsStatus': null,
      });
      expect(result, isInstanceOf<List<Item>>());
      expect(result.first.toString(), expected.toString());
    });
  });
  group('paradeTest', () {
    test('tdl parade success', () async {
      final client = MockClient();
      when(client.get(tdlParadeUrl, headers: requestHeaders))
          .thenAnswer((_) async => http.Response(tdlParadeRes, 200));
      var result = await getTdlParade();
      var expected = Parade.fromMap({
        'FacilityName': '東京ディズニーランド・エレクトリカルパレード・ドリームライツ',
        'FacilityURLSP':
            'http://www.tokyodisneyresort.jp/sp/show/detail/str_id:pw_dreamlights/',
        'FacilityStatus': null,
        'operatingHours': [
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
        'UpdateTime': '19:25',
      });
      expect(result, isInstanceOf<List<Item>>());
      expect(result.first.toString(), expected.toString());
    });
    test('tds parade success', () async {
      final client = MockClient();
      when(client.get(tdlParadeUrl, headers: requestHeaders))
          .thenAnswer((_) async => http.Response(tdsParadeRes, 200));
      var result = await getTdsParade();
      var expected = Parade.fromMap({
        'FacilityName': 'ファンタズミック！',
        'FacilityURLSP':
            'http://www.tokyodisneyresort.jp/sp/show/detail/str_id:mh_fantasmic/',
        'FacilityStatus': null,
        'operatingHours': [
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
        'UpdateTime': '8:00',
      });
      expect(result, isInstanceOf<List<Item>>());
      expect(result.first.toString(), expected.toString());
    });
  });
  group('greetingTest', () {
    test('tdl greeting success', () async {
      final client = MockClient();
      when(client.get(tdlGreetingUrl, headers: requestHeaders))
          .thenAnswer((_) async => http.Response(tdlGreetingRes, 200));
      var result = await getTdlGreeting();
      var expected = Greeting.fromMap({
        'FacilityName': 'ベビーカー＆車イス・レンタル側',
        'AreaJName': 'ワールドバザール',
        'FacilityURLSP':
            'http://www.tokyodisneyresort.jp/sp/greeting/detail/str_id:gre_rental/',
        'FacilityStatus': '運営・公演中止',
        'StandbyTime': null,
        'operatinghours': null,
        'UpdateTime': '8:00',
      });
      expect(result, isInstanceOf<List<Item>>());
      expect(result.first.toString(), expected.toString());
    });
    test('tds greeting success', () async {
      final client = MockClient();
      when(client.get(tdsGreetingUrl, headers: requestHeaders))
          .thenAnswer((_) async => http.Response(tdsGreetingUrl, 200));
      var result = await getTdsGreeting();
      var expected = Greeting.fromMap({
        'FacilityName': 'ディズニーシー・プラザ（ヴァレンティーナズ・スウィート側）',
        'AreaJName': 'メディテレーニアンハーバー',
        'FacilityURLSP':
            'http://www.tokyodisneyresort.jp/sp/greeting/detail/str_id:gre_plaza/',
        'FacilityStatus': null,
        'StandbyTime': null,
        'operatinghours': [
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
        'UpdateTime': '15:16',
      });
      expect(result, isInstanceOf<List<Item>>());
      expect(result.first.toString(), expected.toString());
    });
  });
  group('restaurantTest', () {
    test('tdl restaurant success', () async {
      final client = MockClient();
      when(client.get(tdlRestaurantUrl, headers: requestHeaders))
          .thenAnswer((_) async => http.Response(tdlRestaurantRes, 200));
      var result = await getTdlRestaurant();
      var expected = Restaurant.fromMap({
        'FacilityName': 'れすとらん北齋',
        'FacilityURLSP':
            'http://www.tokyodisneyresort.jp/sp/restaurant/detail/str_id:JRH/',
        'FacilityStatus': null,
        'StandbyTimeMin': '20',
        'StandbyTimeMax': '20',
        'operatingHours': [
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
        'UpdateTime': '20:08',
        'PopCornFlavors': null,
      });
      expect(result, isInstanceOf<List<Item>>());
      expect(result.first.toString(), expected.toString());
    });
    test('tds restaurant success', () async {
      final client = MockClient();
      when(client.get(tdsRestaurantUrl, headers: requestHeaders))
          .thenAnswer((_) async => http.Response(tdsRestaurantRes, 200));
      var result = await getTdsRestaurant();
      var expected = Restaurant.fromMap({
        'FacilityName': 'S.S.コロンビア・ダイニングルーム',
        'FacilityURLSP':
            'http://www.tokyodisneyresort.jp/sp/restaurant/detail/str_id:SSD/',
        'FacilityStatus': null,
        'StandbyTimeMin': null,
        'StandbyTimeMax': null,
        'operatingHours': [
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
        'UpdateTime': '20:16',
        'PopCornFlavors': null,
      });
      expect(result, isInstanceOf<List<Item>>());
      expect(result.first.toString(), expected.toString());
    });
  });
  group('rehabilitateTest', () {
    test('tdl rehabilitate success', () async {
      final client = MockClient();
      when(client.get(tdlRehabilitateUrl, headers: requestHeaders))
          .thenAnswer((_) async => http.Response(tdlStatusRes, 200));
      var result = await getTdlRehabilitate();
      var expected = Rehabilitate(
        'ウエスタンリバー鉄道',
        '2019/5/7-2019/9/3',
        'https://www.tokyodisneyresort.jp/tdl/attraction/detail/154/'
      );
      expect(result, isInstanceOf<List<Item>>());
      expect(result.first.toString(), expected.toString());
    });
    test('tds rehabilitate success', () async {
      final client = MockClient();
      when(client.get(tdsRehabilitateUrl, headers: requestHeaders))
          .thenAnswer((_) async => http.Response(tdsRestaurantRes, 200));
      var result = await getTdsRehabilitate();
      var expected = Rehabilitate(
          'センター・オブ・ジ・アース',
          '2019/9/2-2019/11/30',
          'https://www.tokyodisneyresort.jp/tds/attraction/detail/223/'
      );
      expect(result, isInstanceOf<List<Item>>());
      expect(result.first.toString(), expected.toString());
    });
  });
  group('statusTest', () {
    test('tdl status success', () async {
      final client = MockClient();
      when(client.get(tdlStatusUrl, headers: requestHeaders))
          .thenAnswer((_) async => http.Response(tdlStatusRes, 200));
      var result = await getTdlStatus();
      expect(result, isInstanceOf<String>());
      expect(result, 'ただいま東京ディズニーランドは、当日券の販売を行っております。');
    });
    test('tds status success', () async {
      final client = MockClient();
      when(client.get(tdsStatusUrl, headers: requestHeaders))
          .thenAnswer((_) async => http.Response(tdsStatusRes, 200));
      var result = await getTdsStatus();
      expect(result, isInstanceOf<String>());
      expect(result, 'ただいま東京ディズニーシーは、当日券の販売を行っております。');
    });
  });
}
