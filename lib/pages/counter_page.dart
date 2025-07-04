import 'package:lottodash/components/LeftDraw.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class CounterPage extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const CounterPage({super.key, required this.onToggleTheme});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

List<OverlayPosition> positions = [
  OverlayPosition.left,
  OverlayPosition.left,
  OverlayPosition.bottom,
  OverlayPosition.bottom,
  OverlayPosition.top,
  OverlayPosition.top,
  OverlayPosition.right,
  OverlayPosition.right,
];

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;
  int _selected = 0;

  NavigationBarAlignment alignment = NavigationBarAlignment.spaceBetween;
  bool expands = true;
  NavigationLabelType labelType = NavigationLabelType.selected;
  bool customButtonStyle = true;
  bool expanded = true;
  void _incrementCounter() {
    setState(() => _counter++);
  }

  NavigationItem buildButton(String label, IconData icon) {
    return NavigationItem(
      style: customButtonStyle
          ? const ButtonStyle.muted(density: ButtonDensity.icon)
          : null,
      selectedStyle: customButtonStyle
          ? const ButtonStyle.fixed(density: ButtonDensity.icon)
          : null,
      label: Text(label),
      child: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [
        OutlinedContainer(
          clipBehavior: Clip.antiAlias,
          child: AppBar(
            // header: const Text('This is Header'),
            // title: const Text('This is Title'),
            // subtitle: const Text('This is Subtitle'),
            leading: [
              OutlineButton(
                density: ButtonDensity.icon,
                onPressed: () {
                  openDrawer(
                    context: context,
                    expands: true,
                    builder: (context) {
                      return LeftDraw();
                    },
                    position: positions[0],
                  );
                },
                child: const Icon(Icons.menu),
              ),
            ],
            trailing: [
              OutlineButton(
                density: ButtonDensity.icon,
                onPressed: () {
                  openSheet(
                    context: context,
                    builder: (context) => Container(
                      alignment: Alignment.center,
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: const Text('Sheet'),
                    ),
                    position: OverlayPosition.right,
                  );
                },
                child: const Icon(LucideIcons.user),
              ),
              OutlineButton(
                density: ButtonDensity.icon,
                onPressed: widget.onToggleTheme,
                child: const Icon(Icons.brightness_6),
              ),
            ],
          ),
        ),
      ],
      footers: [
        const Divider(),
        NavigationBar(
          alignment: alignment,
          labelType: labelType,
          expanded: expanded,
          expands: expands,
          onSelected: (index) {
            setState(() {
              _selected = index;
            });
          },
          index: _selected,
          children: [
            buildButton('Lotto', BootstrapIcons.icon1Circle),
            buildButton('Powerball', BootstrapIcons.icon2Circle),
            buildButton('Daily', BootstrapIcons.icon3Circle),
          ],
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('You have pushed the button this many times:').p(),
              Text('$_counter').h1(),
              PrimaryButton(
                child: const Icon(Icons.add),
                onPressed: _incrementCounter,
              ).p(),
            ],
          ),
        ),
      ),
    );
  }
}
