import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociogram/app/modules/Generalaetting_screen/invite_screen.dart';
import 'package:sociogram/app/modules/activity_screen/control_screen.dart';
import 'package:sociogram/app/modules/activity_screen/recentsearch_screen.dart';
import 'package:sociogram/app/modules/activity_screen/story_screen.dart';
import 'package:sociogram/app/modules/activity_screen/timespent_screen.dart';

import '../../../config/common_textfield.dart';
import 'activity_screen_controller.dart';
import 'history_screen.dart';

class ActivityScreenView extends GetView<ActivityScreenController> {
  const ActivityScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List img = [
      'assets/timer.png',
      'assets/note.png',
      'assets/archive-tick.png',
      'assets/clipboard-tick.png',
      'assets/global-search.png',
      'assets/note.png',
    ];
    List text = [
      'Time Spent',
      'History Account',
      'Archived',
      'Saved',
      'Recent Searches',
      'Content Control',
    ];
    List sutext = [
      "Review all changes you've made to your\naccount.",
      "Review all changes you've made to your\naccount.",
      "Review all changes you've made to your\naccount.",
      "Review all changes you've made to your\naccount.",
      "Review all things you've searched for on\naccount and clear your history search.",
      'Displays settings regarding sensitive\ncontent on your account.',
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            title: const Text(
              'Activity',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            centerTitle: true,
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InviteScreen(),
                      ));
                },
                child: SizedBox(
                    height: 24,
                    width: 24,
                    child: Image.asset('assets/setting-4.png')),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 30),
                  child: textfield1(text: 'Search..', text1: 'Search'),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: img.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (index == 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TimespentScreenView()));
                        } else if (index == 1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const HistoryScreenView()));
                        } else if (index == 2) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const StoryScreenView()));
                        } else if (index == 3) {
                        } else if (index == 4) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                       RecentsearchScreenView()));
                        } else if (index == 5) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ControlScreenView()));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: ListTile(
                          leading: Stack(
                            children: [
                              Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: const Color(0xffF8F9FD),
                                ),
                              ),
                              Positioned(
                                top: 11,
                                left: 0,
                                right: 0,
                                child: SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Image.asset(img[index]),
                                ),
                              ),
                            ],
                          ),
                          title: Text(
                            text[index],
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Urbanist-semibold',
                                fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            sutext[index],
                            style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xff64748B),
                                fontFamily: 'Urbanist-medium',
                                fontWeight: FontWeight.w500),
                          ),
                          trailing: const Icon(Icons.navigate_next),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
