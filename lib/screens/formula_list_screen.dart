import 'package:flutter/material.dart';

import '../widgets/formula_title.dart';
import './casting_weight_screen.dart';
import './casting_module_screen.dart';
import './choke_area_screen.dart';
import './pouring_time_screen.dart';
import './sprue_diameter_screen.dart';
import './sprue_well_screen.dart';
import './pressurized_grating_screen.dart';
import './unpressurized_grating_screen.dart';

class FormulaListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Formula App',
        ),
        backgroundColor: Color(0xff6d0c74),
      ),
      body: Container(
          child: GridView(
        padding: const EdgeInsets.all(10),
        children: <Widget>[
          FormulaTitle(
            title: '1. Casting Modulus',
            
            color1: Color(0xffa8e063),
            
            color2: Color(0xfff76b1c),
            routeHandle: CastingModuleScreen.routeName,
          ),
          FormulaTitle(
            title: '2. Weight of Casting',
            color1: Color(0xff43cea2),
            color2: Color(0xff185a9d),
            routeHandle: CastingWeightScreen.routeName,
          ),
          FormulaTitle(
            title: '3. Pouring Time',
            
            color1: Color(0xffcc2b5e),
            color2: Color(0xff753a88),

            routeHandle: PouringTimeScreen.routeName,
          ),
          FormulaTitle(
            title: '4. Choke Area',
            color1: Color(0xff185a8d),
            color2: Color(0xffb06ab3),
            routeHandle: ChokeAreaScreen.routeName,
          ),
          // FormulaTitle(
          //   title: 'Law of Continuity',
          //   color1: Color(0xff4568dc),
          //   color2: Color(0xffb06ab3),
          //   routeHandle: LawOfContinuity.routeName,
          // ),
          FormulaTitle(
            title: '5. Spure diameter at top',
            
            color1: Color(0xfffad961),
            color2: Color(0xff56ab2f),
            routeHandle: SprueDiameterScreen.routeName,
          ),
            FormulaTitle(
            title: '6. Sprue well design',
            color1: Color(0xff43cea2),
            color2: Color(0xfff76b1d),
            routeHandle: SprueWellScreen.routeName,
          ),
          FormulaTitle(
            title: '7. Pressurized Grating',
            color1: Color(0xffb06ab3),
            color2: Color(0xff56ab2f),
            routeHandle: PressurizedGratingScreen.routeName,
          ),
          FormulaTitle(
            title: '8. Un-Pressurized Grating',
            color1: Color(0xffde6262),
            color2: Color(0xff43cea2),
            routeHandle: UnpressurizedGratingScreen.routeName,
          ),
        ],
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      )),
    );
  }
}
