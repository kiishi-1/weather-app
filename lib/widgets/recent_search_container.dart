import 'package:flutter/material.dart';

class RecentSearchContainer extends StatelessWidget {
  const RecentSearchContainer({Key? key, required this.color})
      : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.all(12),
      height: 125,
      width: 125,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
      ),
      child: Column(
        children: [
          const Text(
            'Location',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 45,
            width: 65,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/sunny.png'), //fit: BoxFit.cover
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
               Text(
                '13°',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
               SizedBox(
                width: 8,
              ),
              Text(
                'sunny',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
