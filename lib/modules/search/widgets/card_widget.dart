import 'package:flutter/material.dart';
import 'package:google_search/core/models/google_search_model.dart';

class CardWidget extends StatelessWidget {
  final GoogleSearchModel googleSearchModel;
  const CardWidget({
    super.key,
    required this.googleSearchModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            googleSearchModel.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            onPressed: () async {
              //final url = Uri.parse(googleSearchModel.link);
              //if (await canLaunchUrl(url)) {
              //  await launchUrl(url);
              //}
            },
            child: const Text('Visitar link'),
          ),
        ],
      ),
    );
  }
}
