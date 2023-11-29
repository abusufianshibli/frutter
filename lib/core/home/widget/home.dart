import 'package:flutter/material.dart';
import 'package:frutter/common/utils/route/route.dart';
import 'package:frutter/common/utils/theme/custom_themes.dart';
import 'package:frutter/common/utils/theme/text_theme.dart';
import 'package:frutter/common/widgets/custom_card.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Home View"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomCard(onTap:(){
              Navigator.pushNamed(context, RouteName.customOrder);
            }, borderRadius: 60,child: Text("Custom Order",style: theme.textTheme.headlineLarge,),),
            CustomCard(
              onTap: (){
                Navigator.pushNamed(context, RouteName.feedback);

              },
              borderRadius: 60,child: Text("Feedback",style: theme.textTheme.headlineLarge,),),

          ],
        ),
      ),
    );
  }
}
