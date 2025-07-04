import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:lottodash/components/EditProfileDialog.dart' as EditProfile;

class LeftDraw extends StatefulWidget {
  const LeftDraw({super.key});
  @override
  State<LeftDraw> createState() => _LottoSidebarState();
}

class _LottoSidebarState extends State<LeftDraw> {
  bool expanded = true;
  int selected = 0;

  NavigationItem buildButton(String text, IconData icon, VoidCallback onTap) {
    return NavigationItem(
      label: Text(text),
      alignment: Alignment.centerLeft,
      selectedStyle: const ButtonStyle.primaryIcon(),
      child: Icon(icon),
    );
  }

  NavigationLabel buildLabel(String label) {
    return NavigationLabel(
      alignment: Alignment.centerLeft,
      child: Text(label).semiBold().muted(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return OutlinedContainer(
      height: double.infinity,
      width: expanded ? 260 : 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NavigationRail(
            labelType: NavigationLabelType.expanded,
            labelPosition: NavigationLabelPosition.end,
            alignment: NavigationRailAlignment.start,
            expanded: expanded,
            index: selected,
            onSelected: (value) {
              setState(() {
                selected = value;
                // TODO: Handle navigation per selected index if needed
              });
            },
            children: [
              // --- "You" Section ---
              buildLabel('You'),
              buildButton(
                'Historical Results',
                Icons.history,
                () => Navigator.pushNamed(context, '/results'),
              ),
              buildButton(
                'Hot/Cold Stats',
                Icons.local_fire_department_outlined,
                () => Navigator.pushNamed(context, '/frequency'),
              ),
              buildButton(
                'Ticket Scanner',
                Icons.qr_code_scanner,
                () => Navigator.pushNamed(context, '/scanner'),
              ),

              const NavigationDivider(),

              // --- "Tools" Section ---
              buildLabel('Tools'),
              buildButton(
                'Prediction Generator',
                Icons.casino,
                () => Navigator.pushNamed(context, '/predictor'),
              ),
              buildButton(
                'Match Checker',
                Icons.check_circle_outline,
                () => Navigator.pushNamed(context, '/match-checker'),
              ),
              buildButton(
                'Saved Tickets',
                Icons.bookmark_outline,
                () => Navigator.pushNamed(context, '/tickets'),
              ),

              const NavigationDivider(),

              // --- "Alerts" Section ---
              buildLabel('Alerts'),
              buildButton(
                'Jackpot Alerts',
                Icons.notifications_outlined,
                () => Navigator.pushNamed(context, '/alerts'),
              ),
              buildButton(
                'Number Trends',
                Icons.timeline,
                () => Navigator.pushNamed(context, '/trends'),
              ),
              buildButton(
                'Draw Reminders',
                Icons.alarm,
                () => Navigator.pushNamed(context, '/reminders'),
              ),
              buildButton(
                'Compare Numbers',
                Icons.compare_arrows_outlined,
                () => Navigator.pushNamed(context, '/compare'),
              ),

              // --- Footer Avatar ---
              NavigationButton(
                alignment: Alignment.centerLeft,
                label: const Text('Historical Results'),
                child: const Icon(Icons.history),
                onPressed: () => Navigator.pushNamed(context, '/results'),
              ),
            ],
          ),
          const VerticalDivider(width: 1),
          // Sidebar content area (expand as needed)
          const Flexible(child: SizedBox()),
        ],
      ),
    );
  }
}
