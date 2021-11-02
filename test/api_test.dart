import 'dart:io';

import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grandis/api.dart';
import 'package:grandis/model.dart';

final String tdlAttractionRes = '''
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
final String tdsAttractionRes = '''
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
final String tdlParadeRes = '''
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
final String tdsParadeRes = '''
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
final String tdlGreetingRes = '''
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
final String tdsGreetingRes = '''
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
final String tdlRestaurantRes = '''
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
final String tdsRestaurantRes = '''
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
final String tdlRehabilitateRes = '''
<div class="linkList6">
  <ul>
    <li><a href="/tdl/attraction/detail/154/"><span>
    <p>ウエスタンリバー鉄道</p><p class="date">2019/5/7 - 2019/9/3<br></p>
    </span></a></li>
  </ul>
</div>
''';
final String tdsRehabilitateRes = '''
<div class="linkList6">
  <ul>
    <li><a href="/tds/attraction/detail/223/"><span>
    <p>センター・オブ・ジ・アース</p>
    <p class="date">2019/9/2 - 2019/11/30<br></p>
    </span></a></li>
  </ul>
</div>
''';
final String tdlStatusRes = '''
<div class="section-noborder">
  <h3 class="heading3">当日券販売状況</h3>
  <p>ただいま東京ディズニーランドは、当日券の販売を行っております。</p>
</div>
''';
final String tdsStatusRes = '''
<div class="section-noborder">
  <h3 class="heading3">当日券販売状況</h3>
  <p>ただいま東京ディズニーシーは、当日券の販売を行っております。</p>
</div>
''';

void main() {
  group('attractionTest', () {
    test('tdl attraction success', () async {
      var result = await TdrClient(MockClient((_) async {
        return Response(tdlAttractionRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      })).getTdlAttraction();
      expect(result, isInstanceOf<List<Item>>());
      expect(result[0].getTitle(), 'アリスのティーパーティー');
    });
    test('tds attraction success', () async {
      var result = await TdrClient(MockClient((_) async {
        return Response(tdsAttractionRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      })).getTdsAttraction();
      expect(result, isInstanceOf<List<Item>>());
      expect(result[0].getTitle(), 'アクアトピア');
    });
  });
  group('paradeTest', () {
    test('tdl parade success', () async {
      var result = await TdrClient(MockClient((_) async {
        return Response(tdlParadeRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      })).getTdlParade();
      expect(result, isInstanceOf<List<Item>>());
      expect(result[0].getTitle(), '東京ディズニーランド・エレクトリカルパレード・ドリームライツ');
    });
    test('tds parade success', () async {
      var result = await TdrClient(MockClient((_) async {
        return Response(tdsParadeRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      })).getTdsParade();
      expect(result, isInstanceOf<List<Item>>());
      expect(result[0].getTitle(), 'ファンタズミック！');
    });
  });
  group('greetingTest', () {
    test('tdl greeting success', () async {
      var result = await TdrClient(MockClient((_) async {
        return Response(tdlGreetingRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      })).getTdlGreeting();
      expect(result, isInstanceOf<List<Item>>());
      expect(result[0].getTitle(), 'ベビーカー＆車イス・レンタル側');
    });
    test('tds greeting success', () async {
      var result = await TdrClient(MockClient((_) async {
        return Response(tdsGreetingRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      })).getTdsGreeting();
      expect(result, isInstanceOf<List<Item>>());
      expect(result[0].getTitle(), 'ディズニーシー・プラザ（ヴァレンティーナズ・スウィート側）');
    });
  });
  group('restaurantTest', () {
    test('tdl restaurant success', () async {
      var result = await TdrClient(MockClient((_) async {
        return Response(tdlRestaurantRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      })).getTdlRestaurant();
      expect(result, isInstanceOf<List<Item>>());
      expect(result[0].getTitle(), 'れすとらん北齋');
    });
    test('tds restaurant success', () async {
      var result = await TdrClient(MockClient((_) async {
        return Response(tdsRestaurantRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      })).getTdsRestaurant();
      expect(result, isInstanceOf<List<Item>>());
      expect(result[0].getTitle(), 'S.S.コロンビア・ダイニングルーム');
    });
  });
  group('rehabilitateTest', () {
    test('tdl rehabilitate success', () async {
      var result = await TdrClient(MockClient((_) async {
        return Response(tdlRehabilitateRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      })).getTdlRehabilitate();
      expect(result, isInstanceOf<List<Item>>());
      expect(result[0].getTitle(), 'ウエスタンリバー鉄道');
    });
    test('tds rehabilitate success', () async {
      var result = await TdrClient(MockClient((_) async {
        return Response(tdsRehabilitateRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      })).getTdsRehabilitate();
      expect(result, isInstanceOf<List<Item>>());
      expect(result[0].getTitle(), 'センター・オブ・ジ・アース');
    });
  });
  group('statusTest', () {
    test('tdl status success', () async {
      var client = TdrClient(MockClient((_) async {
        return Response(tdlStatusRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      }));
      var result = await client.getTdlStatus();
      expect(result, isInstanceOf<String>());
      expect(result, 'ただいま東京ディズニーランドは、当日券の販売を行っております。');
    });
    test('tds status success', () async {
      var result = await TdrClient(MockClient((_) async {
        return Response(tdsStatusRes, 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
      })).getTdsStatus();
      expect(result, isInstanceOf<String>());
      expect(result, 'ただいま東京ディズニーシーは、当日券の販売を行っております。');
    });
  });
}
