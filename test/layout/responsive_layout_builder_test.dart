import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';

import '../helpers/helpers.dart';

void main() {
  group('ResponsiveLayout', () {
    testWidgets(
        'displays an xlarge layout '
        'for sizes greater than large', (tester) async {
      tester.setDisplaySize(const Size(PuzzleBreakpoints.large + 1, 800));

      const smallKey = Key('__small__');
      const mediumKey = Key('__medium__');
      const largeKey = Key('__large__');
      const xlargeKey = Key('__xlarge__');

      await tester.pumpApp(
        ResponsiveLayoutBuilder(
          small: (_, __) => const SizedBox(key: smallKey),
          medium: (_, __) => const SizedBox(key: mediumKey),
          large: (_, __) => const SizedBox(key: largeKey),
          xlarge: (_, __) => const SizedBox(key: xlargeKey),
        ),
      );

      expect(find.byKey(smallKey), findsNothing);
      expect(find.byKey(mediumKey), findsNothing);
      expect(find.byKey(largeKey), findsNothing);
      expect(find.byKey(xlargeKey), findsOneWidget);
    });

    group('on an xlarge display', () {
      testWidgets('displays an xlarge layout', (tester) async {
        tester.setXLargeDisplaySize();

        const smallKey = Key('__small__');
        const mediumKey = Key('__medium__');
        const largeKey = Key('__large__');
        const xlargeKey = Key('__xlarge__');

        await tester.pumpApp(
          ResponsiveLayoutBuilder(
            small: (_, __) => const SizedBox(key: smallKey),
            medium: (_, __) => const SizedBox(key: mediumKey),
            large: (_, __) => const SizedBox(key: largeKey),
            xlarge: (_, __) => const SizedBox(key: xlargeKey),
          ),
        );

        expect(find.byKey(smallKey), findsNothing);
        expect(find.byKey(mediumKey), findsNothing);
        expect(find.byKey(largeKey), findsNothing);
        expect(find.byKey(xlargeKey), findsOneWidget);
      });

      testWidgets('displays child when available', (tester) async {
        tester.setXLargeDisplaySize();

        const smallKey = Key('__small__');
        const mediumKey = Key('__medium__');
        const largeKey = Key('__large__');
        const xlargeKey = Key('__xlarge__');
        const childKey = Key('__child__');

        await tester.pumpApp(
          ResponsiveLayoutBuilder(
            small: (_, child) => SizedBox(key: smallKey, child: child),
            medium: (_, child) => SizedBox(key: mediumKey, child: child),
            large: (_, child) => SizedBox(key: largeKey, child: child),
            xlarge: (_, child) => SizedBox(key: xlargeKey, child: child),
            child: (_) => const SizedBox(key: childKey),
          ),
        );

        expect(find.byKey(smallKey), findsNothing);
        expect(find.byKey(mediumKey), findsNothing);
        expect(find.byKey(largeKey), findsNothing);
        expect(find.byKey(xlargeKey), findsOneWidget);
        expect(find.byKey(childKey), findsOneWidget);
      });

      testWidgets('returns xlarge layout size for child', (tester) async {
        tester.setXLargeDisplaySize();

        ResponsiveLayoutSize? layoutSize;
        await tester.pumpApp(
          ResponsiveLayoutBuilder(
            small: (_, child) => child!,
            medium: (_, child) => child!,
            large: (_, child) => child!,
            xlarge: (_, child) => child!,
            child: (currentLayoutSize) {
              layoutSize = currentLayoutSize;
              return const SizedBox();
            },
          ),
        );

        expect(
          layoutSize,
          equals(ResponsiveLayoutSize.xlarge),
        );
      });
    });

    group('on a large display', () {
      testWidgets('displays a large layout', (tester) async {
        tester.setLargeDisplaySize();

        const smallKey = Key('__small__');
        const mediumKey = Key('__medium__');
        const largeKey = Key('__large__');
        const xlargeKey = Key('__xlarge__');

        await tester.pumpApp(
          ResponsiveLayoutBuilder(
            small: (_, __) => const SizedBox(key: smallKey),
            medium: (_, __) => const SizedBox(key: mediumKey),
            large: (_, __) => const SizedBox(key: largeKey),
            xlarge: (_, __) => const SizedBox(key: largeKey),
          ),
        );

        expect(find.byKey(smallKey), findsNothing);
        expect(find.byKey(mediumKey), findsNothing);
        expect(find.byKey(largeKey), findsOneWidget);
        expect(find.byKey(xlargeKey), findsNothing);
      });

      testWidgets('displays child when available', (tester) async {
        tester.setLargeDisplaySize();

        const smallKey = Key('__small__');
        const mediumKey = Key('__medium__');
        const largeKey = Key('__large__');
        const xlargeKey = Key('__xlarge__');
        const childKey = Key('__child__');

        await tester.pumpApp(
          ResponsiveLayoutBuilder(
            small: (_, child) => SizedBox(key: smallKey, child: child),
            medium: (_, child) => SizedBox(key: mediumKey, child: child),
            large: (_, child) => SizedBox(key: largeKey, child: child),
            xlarge: (_, child) => SizedBox(key: xlargeKey, child: child),
            child: (_) => const SizedBox(key: childKey),
          ),
        );

        expect(find.byKey(smallKey), findsNothing);
        expect(find.byKey(mediumKey), findsNothing);
        expect(find.byKey(largeKey), findsOneWidget);
        expect(find.byKey(xlargeKey), findsNothing);
        expect(find.byKey(childKey), findsOneWidget);
      });

      testWidgets('returns large layout size for child', (tester) async {
        tester.setLargeDisplaySize();

        ResponsiveLayoutSize? layoutSize;
        await tester.pumpApp(
          ResponsiveLayoutBuilder(
            small: (_, child) => child!,
            medium: (_, child) => child!,
            large: (_, child) => child!,
            xlarge: (_, child) => child!,
            child: (currentLayoutSize) {
              layoutSize = currentLayoutSize;
              return const SizedBox();
            },
          ),
        );

        expect(
          layoutSize,
          equals(ResponsiveLayoutSize.large),
        );
      });
    });

    group('on a medium display', () {
      testWidgets('displays a medium layout', (tester) async {
        tester.setMediumDisplaySize();

        const smallKey = Key('__small__');
        const mediumKey = Key('__medium__');
        const largeKey = Key('__large__');
        const xlargeKey = Key('__xlarge__');

        await tester.pumpApp(
          ResponsiveLayoutBuilder(
            small: (_, __) => const SizedBox(key: smallKey),
            medium: (_, __) => const SizedBox(key: mediumKey),
            large: (_, __) => const SizedBox(key: largeKey),
            xlarge: (_, __) => const SizedBox(key: xlargeKey),
          ),
        );

        expect(find.byKey(smallKey), findsNothing);
        expect(find.byKey(mediumKey), findsOneWidget);
        expect(find.byKey(largeKey), findsNothing);
        expect(find.byKey(xlargeKey), findsNothing);
      });

      testWidgets('displays child when available', (tester) async {
        tester.setMediumDisplaySize();

        const smallKey = Key('__small__');
        const mediumKey = Key('__medium__');
        const largeKey = Key('__large__');
        const xlargeKey = Key('__xlarge__');
        const childKey = Key('__child__');

        await tester.pumpApp(
          ResponsiveLayoutBuilder(
            small: (_, child) => SizedBox(key: smallKey, child: child),
            medium: (_, child) => SizedBox(key: mediumKey, child: child),
            large: (_, child) => SizedBox(key: largeKey, child: child),
            xlarge: (_, child) => SizedBox(key: largeKey, child: child),
            child: (_) => const SizedBox(key: childKey),
          ),
        );

        expect(find.byKey(smallKey), findsNothing);
        expect(find.byKey(mediumKey), findsOneWidget);
        expect(find.byKey(largeKey), findsNothing);
        expect(find.byKey(xlargeKey), findsNothing);
        expect(find.byKey(childKey), findsOneWidget);
      });

      testWidgets('returns medium layout size for child', (tester) async {
        tester.setMediumDisplaySize();

        ResponsiveLayoutSize? layoutSize;
        await tester.pumpApp(
          ResponsiveLayoutBuilder(
            small: (_, child) => child!,
            medium: (_, child) => child!,
            large: (_, child) => child!,
            xlarge: (_, child) => child!,
            child: (currentLayoutSize) {
              layoutSize = currentLayoutSize;
              return const SizedBox();
            },
          ),
        );

        expect(
          layoutSize,
          equals(ResponsiveLayoutSize.medium),
        );
      });
    });

    group('on a small display', () {
      testWidgets('displays a small layout', (tester) async {
        tester.setSmallDisplaySize();

        const smallKey = Key('__small__');
        const mediumKey = Key('__medium__');
        const largeKey = Key('__large__');
        const xlargeKey = Key('__xlarge__');

        await tester.pumpApp(
          ResponsiveLayoutBuilder(
            small: (_, __) => const SizedBox(key: smallKey),
            medium: (_, __) => const SizedBox(key: mediumKey),
            large: (_, __) => const SizedBox(key: largeKey),
            xlarge: (_, __) => const SizedBox(key: xlargeKey),
          ),
        );

        expect(find.byKey(smallKey), findsOneWidget);
        expect(find.byKey(mediumKey), findsNothing);
        expect(find.byKey(largeKey), findsNothing);
        expect(find.byKey(xlargeKey), findsNothing);
      });

      testWidgets('displays child when available', (tester) async {
        tester.setSmallDisplaySize();

        const smallKey = Key('__small__');
        const mediumKey = Key('__medium__');
        const largeKey = Key('__large__');
        const xlargeKey = Key('__xlarge__');
        const childKey = Key('__child__');

        await tester.pumpApp(
          ResponsiveLayoutBuilder(
            small: (_, child) => SizedBox(key: smallKey, child: child),
            medium: (_, child) => SizedBox(key: mediumKey, child: child),
            large: (_, child) => SizedBox(key: largeKey, child: child),
            xlarge: (_, child) => SizedBox(key: xlargeKey, child: child),
            child: (_) => const SizedBox(key: childKey),
          ),
        );

        expect(find.byKey(smallKey), findsOneWidget);
        expect(find.byKey(mediumKey), findsNothing);
        expect(find.byKey(largeKey), findsNothing);
        expect(find.byKey(xlargeKey), findsNothing);
        expect(find.byKey(childKey), findsOneWidget);

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      });

      testWidgets('returns small layout size for child', (tester) async {
        tester.setSmallDisplaySize();

        ResponsiveLayoutSize? layoutSize;
        await tester.pumpApp(
          ResponsiveLayoutBuilder(
            small: (_, child) => child!,
            medium: (_, child) => child!,
            large: (_, child) => child!,
            xlarge: (_, child) => child!,
            child: (currentLayoutSize) {
              layoutSize = currentLayoutSize;
              return const SizedBox();
            },
          ),
        );

        expect(
          layoutSize,
          equals(ResponsiveLayoutSize.small),
        );
      });
    });
  });
}
