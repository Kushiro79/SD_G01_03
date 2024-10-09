part of '../page.dart';

class _NavigationMenu extends StatefulWidget {
  const _NavigationMenu();

  @override
  State<_NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<_NavigationMenu> {
  bool _isListenerAdded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isListenerAdded) {
      AutoRouterDelegate.of(context).addListener(() {
        if (mounted) setState(() {});
      });
      _isListenerAdded = true;
    }
  }

  void _onTabTap(PageRouteInfo<dynamic> route) {
    context.pushRoute(route);
  }

  @override
  Widget build(BuildContext context) {
    final currentUrl = AutoRouterDelegate.of(context).urlState.path;
    final screenwidth = MediaQuery.of(context).size.width > 850;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: Image(
                    image: AssetImage(ProjectAssets.learnSphereLogo.path),
                    color: const Color.fromARGB(255, 0, 0, 0),
                    width: screenwidth ? 200 : 80,
                    height: screenwidth ? 100 : 80,
                  ),
                ),
              const SizedBox(height: 70),
              _MenuItem(
                iconPath: ProjectAssets.icons.home.path,
                isSelected: currentUrl == '/dashboard',
                onTap: () => _onTabTap(const DashboardRoute()),
                text: 'Dashboard',
              ),
              _MenuItem(
                iconPath: ProjectAssets.graduate.path,
                isSelected: currentUrl == '/view-academic-qualifications',
                onTap: () => _onTabTap(const ViewAcademicQualificationsRoute()),
                text: 'User Academic\n Qualifications',
              ),
              _MenuItem(
                iconPath: ProjectAssets.feedback.path,
                isSelected: currentUrl == '/view-feedback',
                onTap: () => _onTabTap(const ViewFeedbackRoute()),
                text: 'User Feedback',
              ),
              _MenuItem(
                iconPath: ProjectAssets.tagUser1.path,
                isSelected: currentUrl == '/user-management',
                onTap: () => _onTabTap(const ViewAndManageUsersRoute()),
                text: 'User & Staff Management',
              ),
              _MenuItem(
                iconPath: ProjectAssets.icons.setting2.path,
                isSelected: currentUrl == '/settings',
                onTap: () => _onTabTap(const SettingsRoute()),
                text: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.iconPath,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  final String iconPath;
  final String text;
  final bool isSelected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width > 1400;
    final iconsize = screenwidth ? 20.0 : 24.0;

    return InkWell(
        onTap: onTap,
          child: Container(
            height: 42,
            margin: const EdgeInsets.only(
              bottom: 25,
            ),
            decoration: isSelected
                ? const BoxDecoration(
                    color: Palette.lightBlue,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  )
                : null,
            child: screenwidth
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      iconPath.endsWith('.svg')
                          ? SvgPicture.asset(
                              iconPath,
                              width: iconsize,
                              height: iconsize,
                              colorFilter: Palette.dirtyWhite.toColorFilter,
                            )
                          : Image.asset(
                              iconPath,
                              width: iconsize,
                              height: iconsize,
                              color: Palette.dirtyWhite,
                            ),
                      const SizedBox(width: 8),
                      Text(
                        text,
                        style: isSelected
                            ? TextStyles.myriadProSemiBold12DirtyWhite.copyWith(
                                fontSize: 16,
                              )
                            : TextStyles.myriadProSemiBold12DirtyWhite.copyWith(
                                color: Palette.dirtyWhite.withOpacity(0.8),
                                fontSize: 16,
                              ),
                      ),
                    ],
                  )
                : Center(
                    // Center the icon when text is hidden
                    child: iconPath.endsWith('.svg')
                        ? SvgPicture.asset(
                            iconPath,
                            width: iconsize,
                            height: iconsize,
                            colorFilter: Palette.dirtyWhite.toColorFilter,
                          )
                        : Image.asset(
                            iconPath,
                            width: iconsize,
                            height: iconsize,
                            color: Palette.dirtyWhite,
                          ),
                  ),
          ),
        );
  }
}
