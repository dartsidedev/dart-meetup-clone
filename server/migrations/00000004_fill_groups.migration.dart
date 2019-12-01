import 'dart:async';
import 'package:aqueduct/aqueduct.dart';

class Migration4 extends Migration {
  @override
  Future upgrade() async {}

  @override
  Future downgrade() async {}

  @override
  Future seed() async {
    final labels = [
      'Flutter',
      'Dart',
      'JavaScript',
      'Kotlin',
      'Android',
      'iOS',
      'Swift',
      'Test-Driven Development',
      'Software Development',
      'Computer Programming',
      'Mobile Development'
    ];
    final exec = database.store.execute;
    for (final label in labels) {
      await exec(
        'INSERT INTO _Label (name) VALUES (@name)',
        substitutionValues: {'name': label},
      );
    }

    var buildGroup = (String name, String description) =>
        {'name': name, 'description': description};

    final groups = [
      buildGroup(
        'Flutter Munich',
        'We learn about Flutter and build beautiful native apps in record time. We organize talks, viewing parties and coding nights. All skill levels are welcome. Dart rocks.',
      ),
      buildGroup(
        'Kotlin User Group Munich',
        'Kotlin, an open source language for the JVM and more.\n\n'
            'Topics of this group are both the Kotlin language itself and its use in development.',
      ),
      buildGroup(
        'GDG Android Munich',
        '''This is Munich's Google Developer Group (GDG) focused on Android development. We organize events with talks and discussions about various topics around Android technology. Let us know if you have something to share, we are always looking for speakers!\n\nDisclaimer: GDG Android Munich is an independent group; our activities and the opinions expressed on this page should in no way be linked to Google, the corporation.''',
      ),
      buildGroup(
        'Munich iOS Developers Meetup',
        '''Welcome to the Munich iOS Developers meetup group. This is a group to learn and share iOS experiences. Use this group to learn tricks, network with other iOS developers, share your experiences and see interesting presentations or demos.

If you're interested about speaking on any iOS related topic, or presenting your app please contact us.

We also have a Slack channel were we discuss anything related to iOS, send us a private message and we will add you the channel.''',
      ),
    ];
    for (final group in groups) {
      await exec(
        'INSERT INTO _Group (name, description) VALUES (@name, @description)',
        substitutionValues: {
          'name': group['name'],
          'description': group['description'],
        },
      );
    }

    const groupLabels = [
      [1, 1],
      [1, 2],
      [1, 5],
      [1, 6],
      [1, 8],
      [1, 9],
      [1, 10],
      [1, 11],
      [2, 4],
      [2, 5],
      [2, 9],
      [2, 10],
      [2, 11],
      [3, 4],
      [3, 5],
      [3, 9],
      [3, 10],
      [3, 11],
      [4, 6],
      [4, 7],
      [4, 9],
      [4, 10],
      [4, 11],
    ];
    for (final groupLabel in groupLabels) {
      await exec(
        'INSERT INTO _GroupLabel (group_id, label_id) VALUES (@group, @label)',
        substitutionValues: {
          'group': groupLabel[0],
          'label': groupLabel[1],
        },
      );
    }
  }
}
