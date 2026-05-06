import 'package:fit_flex3/core/utils/constants/icon_path.dart' show IconPath;
import 'package:flutter/material.dart';

class MedalsList extends StatelessWidget {
  final List<Map<String, dynamic>> medalsList;

  const MedalsList({super.key, required this.medalsList});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 300,
          width: double.infinity,
          margin: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            color: Color(0xffF2F7FF),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Positioned(
          top: 1,
          left: 0,
          right: 0,
          child: ClipRRect(
            child: Image.asset(
              IconPath.medalscontainerhead,
              width: 360,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 30,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              height: 262,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xFFCCDDFF), width: 2),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: medalsList.length,
                  itemBuilder: (context, index) {
                    final medal = medalsList[index];

                    return Container(
                      width: double.infinity,
                      height: 50,
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xFFB3BAC5), width: 1),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        leading: Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Color(0xFFccddff),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Image.asset(
                            medal['image'],
                            width: 20,
                            height: 20,
                          ),
                        ),
                        title: Text(medal['name']),
                        trailing: Text(medal['distance']),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
