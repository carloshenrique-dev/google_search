import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_search/core/models/google_search_model.dart';
import 'package:google_search/modules/search/widgets/card_widget.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import 'mock_url_launcher.dart';

void main() {
  late MockUrlLauncher mock;

  setUp(() {
    mock = MockUrlLauncher();
    UrlLauncherPlatform.instance = mock;
  });

  testWidgets('CardWidget launches URL when "Visitar link" button is pressed',
      (WidgetTester tester) async {
    final googleSearchModel =
        GoogleSearchModel(title: 'Title', link: 'https://example.com');
    await tester.pumpWidget(
      MaterialApp(
        home: CardWidget(googleSearchModel: googleSearchModel),
      ),
    );

    // Verify that the title is displayed
    expect(find.text('Title'), findsOneWidget);

    // Simulate button press
    await tester.tap(find.text('Visitar link'));
    await tester.pumpAndSettle();

    FollowLink? followLink;

    await tester.pumpWidget(Link(
      uri: Uri.parse('http://example.com/foobar'),
      target: LinkTarget.blank,
      builder: (BuildContext context, FollowLink? followLink2) {
        followLink = followLink2;
        return Container();
      },
    ));

    mock
      ..setLaunchExpectations(
        url: 'http://example.com/foobar',
        launchMode: PreferredLaunchMode.externalApplication,
        universalLinksOnly: false,
        enableJavaScript: true,
        enableDomStorage: true,
        headers: <String, String>{},
        webOnlyWindowName: null,
      )
      ..setResponse(true);
    await followLink!();
    expect(mock.canLaunchCalled, isTrue);
    expect(mock.launchCalled, isTrue);
  });
}
