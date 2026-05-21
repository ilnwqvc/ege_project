import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.title,
    required this.currentIndex,
    required this.body,
  });

  final String title;
  final int currentIndex;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPadding = width < 700 ? 16.0 : 28.0;
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    const navHeight = 64.0;
    final navBottomPadding = bottomInset > 0 ? bottomInset : 12.0;
    final contentBottomPadding = navHeight + navBottomPadding + 24;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 62,
        titleSpacing: horizontalPadding,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: -0.4,
              ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFF4EFE6),
                Color(0xFFF8F4EC),
                Color(0xFFEAF1FF),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 980),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  8,
                  horizontalPadding,
                  contentBottomPadding,
                ),
                child: body,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          0,
          horizontalPadding,
          navBottomPadding,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xEEFFFCF6),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: const Color(0x1A152238)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x220F172A),
                blurRadius: 28,
                offset: Offset(0, 16),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: NavigationBar(
              height: navHeight,
              backgroundColor: Colors.transparent,
              indicatorColor: const Color(0xFFE6EEF9),
              selectedIndex: currentIndex,
              onDestinationSelected: (index) {
                switch (index) {
                  case 0:
                    context.go('/');
                    break;
                  case 1:
                    context.go('/theory');
                    break;
                  case 2:
                    context.go('/quiz');
                    break;
                  case 3:
                    context.go('/progress');
                    break;
                }
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Главная',
                ),
                NavigationDestination(
                  icon: Icon(Icons.menu_book_outlined),
                  selectedIcon: Icon(Icons.menu_book),
                  label: 'Теория',
                ),
                NavigationDestination(
                  icon: Icon(Icons.edit_note_outlined),
                  selectedIcon: Icon(Icons.edit_note),
                  label: 'Тренажер',
                ),
                NavigationDestination(
                  icon: Icon(Icons.insights_outlined),
                  selectedIcon: Icon(Icons.insights),
                  label: 'Прогресс',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
