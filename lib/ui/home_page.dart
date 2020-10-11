import 'package:flutter/material.dart';
import 'package:gametv_assignment/network/ApiResponse.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'dart:convert';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _hasMore;
  int _pageNumber;
  bool _error;
  bool _loading;
  String _cursor;
  final int _defaultPhotosPerPageCount = 10;
  List<Tournament> _tournament;
  final int _nextPageThreshold = 5;

  @override
  void initState() {
    super.initState();
    _hasMore = true;
    _pageNumber = 1;
    _error = false;
    _cursor = "";
    _loading = true;
    _tournament = [];
    fetchTournament();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flyingwolf",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.sort),
          onPressed: () => null,
          color: Colors.black,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: createListview(),
    );
  }

  Widget createListview() {
    return SingleChildScrollView(
        child: Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[getHeader(), getListView()],
      ),
    ));
  }

  Widget getHeader() {
    return Container(
      child: Padding(
          padding: EdgeInsets.fromLTRB(12, 8, 15, 8),
          child: Center(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40.0,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('assets/alucard.jpg'),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.fromLTRB(15, 5, 0, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Abhinav Suman',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              )),
                          Container(
                            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                            padding: EdgeInsets.only(top: 2.0),
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: Colors.blueAccent),
                                  borderRadius: BorderRadius.circular(15.0)),
                              // alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 10.0),
                              child: RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '2250 ',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    TextSpan(
                                        text: 'Elo rating',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey,
                                            fontSize: 10)),
                                  ],
                                ),
                              ),
                              width: 140.0,
                              height: 27.0,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 2.0,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: new LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color.fromARGB(255, 218, 102, 6),
                                  Color.fromARGB(255, 228, 143, 9)
                                ],
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    '34',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    child: Center(
                                      child: Text('Tournaments\nPlayed',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.center),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: new LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color.fromARGB(255, 64, 22, 139),
                                  Color.fromARGB(255, 122, 48, 166)
                                ],
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    '09',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    child: Center(
                                      child: Text('Tournaments\nWon',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.center),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: new LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color.fromARGB(255, 228, 65, 54),
                                  Color.fromARGB(255, 232, 101, 62)
                                ],
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    '26%',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    child: Center(
                                      child: Text('Wining\nPercentage',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.center),
                                    )),
                              ],
                            ),
                          ),
                        )
                      ]),
                ),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 5),
                    child: Text('Recommended for you',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.left),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Column buildStatColumn(String label, int number) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          number.toString(),
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        Container(
            margin: const EdgeInsets.only(top: 4.0),
            child: Text(
              label,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400),
            ))
      ],
    );
  }

  Widget getListView() {
    if (_tournament.isEmpty) {
      if (_loading) {
        return Center(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: CircularProgressIndicator(),
        ));
      } else if (_error) {
        return Center(
            child: InkWell(
          onTap: () {
            setState(() {
              _loading = true;
              _error = false;
              fetchTournament();
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text("Error while loading tournament, tap to try agin"),
          ),
        ));
      }
    } else {
      return Expanded(
        child: ListView.builder(
            itemCount: _tournament.length + (_hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _tournament.length - _nextPageThreshold) {
                fetchTournament();
              }
              if (index == _tournament.length) {
                if (_error) {
                  return Center(
                      child: InkWell(
                    onTap: () {
                      setState(() {
                        _loading = true;
                        _error = false;
                        fetchTournament();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child:
                          Text("Error while loading photos, tap to try agin"),
                    ),
                  ));
                } else {
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: CircularProgressIndicator(),
                  ));
                }
              }
              final Tournament tournament = _tournament[index];
              return Padding(
                child: Card(
                  elevation: 2.0,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    children: <Widget>[
                      Image.network(
                        tournament.cover_url,
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: 110,
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(6, 5, 6, 1),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(tournament.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          )),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(6, 1, 6, 6),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              tournament.game_name,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 10),
                            ),
                          ))
                    ],
                  ),
                ),
                padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
              );
            }),
      );
    }
    return Container();
  }

  Future<void> fetchTournament() async {
    try {
      final response = await http.get(
          "http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all&cursor=$_cursor");
      ApiResponse apiResponse =
          ApiResponse.fromJson(json.decode(response.body));
      print(json.decode(response.body).toString());
      List<Tournament> fetchedPhotos =
          Tournament.parseList(apiResponse.data['tournaments'] as List);
      setState(() {
        _hasMore = fetchedPhotos.length == _defaultPhotosPerPageCount;
        _loading = false;
        _pageNumber = _pageNumber + 1;
        _cursor = apiResponse.data['cursor'];
        _tournament.addAll(fetchedPhotos);
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _error = true;
      });
    }
  }
}

class Tournament {
  final String name;
  final String cover_url;
  final String game_name;

  Tournament(this.name, this.cover_url, this.game_name);

  factory Tournament.fromJson(Map<String, dynamic> json) {
    return Tournament(json["name"], json["cover_url"], json["game_name"]);
  }

  static List<Tournament> parseList(List<dynamic> list) {
    return list.map((i) => Tournament.fromJson(i)).toList();
  }
}
