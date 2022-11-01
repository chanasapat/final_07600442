import 'package:final_07600442/models/team_item.dart';
import 'package:flutter/material.dart';
import 'package:final_07600442/services/api.dart';

class WorldCupPage extends StatefulWidget {
  const WorldCupPage({Key? key}) : super(key: key);

  @override
  _WorldCupPageState createState() => _WorldCupPageState();
}

class _WorldCupPageState extends State<WorldCupPage> {
  List<TeamItem>? _teamList;
  var _isLoading = false;
  String? _errMessage;

  @override
  void initState() {
    super.initState();
    _fetchTeamData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/bg.png'),
                fit: BoxFit.cover,
              )
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(8.01), // FLUTTER BUG FIX
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 0),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset('images/logo.jpg', height: 100.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(8.01), // FLUTTER BUG FIX
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 0),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                )
              ),
              Expanded(
                child: Stack(
                  children: [
                    if (_teamList != null)
                      ListView.builder(
                        itemBuilder: _buildListItem,
                        itemCount: _teamList!.length,
                      ),
                    if (_isLoading)
                      const Center(child: CircularProgressIndicator()),
                    if (_errMessage != null && !_isLoading)
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Text(_errMessage!),
                            ),
                          ],
                        ),
                      ),
                  ],
                )
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: ElevatedButton(
                      onPressed: () {
                      }, child: const Text('VIEW RESULT',style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  void _fetchTeamData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var data = await Api().fetch('teams');
      setState(() {
        _teamList = data
            .map<TeamItem>((item) => TeamItem.fromJson(item))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Widget _buildListItem(BuildContext context, int index) {
    var teamItem = _teamList![index];

    return Card(
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Image.network(
              teamItem.flagImage,
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8.0),
            Text(teamItem.team),
          ],
        ),
      ),
    );
  }
}



