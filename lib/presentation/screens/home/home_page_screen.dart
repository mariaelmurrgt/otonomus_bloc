import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import 'package:otonomus/business_logic/blocs.dart';
import 'package:otonomus/data/enums/enums.dart';
import 'package:otonomus/data/models/property_model.dart';
import 'package:otonomus/presentation/shared_widgets/shared_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    print("initState called");
    BlocProvider.of<HomeBloc>(context).add(GetAllProperties());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        print(
            '${state.status}, ${state.properties}, ${state.selectedProperty}');

        return Stack(
          children: [
            Scaffold(
              key: _scaffoldKey,
              drawer: MyDrawer(),
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(140),
                child: AppBar(
                  automaticallyImplyLeading: false,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  )),
                  toolbarHeight: 140,
                  backgroundColor: Color(0xFF3C4955),
                  title: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                _scaffoldKey.currentState?.openDrawer();
                              },
                              icon: SvgIcon(
                                  icon: SvgIconData(
                                      'assets/icons/burgerIcon.svg'))),
                          SizedBox(width: 8),
                          Expanded(
                            child: Container(
                                height: 40,
                                width: 310,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 5,
                                      top: 8,
                                      child: Container(
                                        height: 24,
                                        width: 24,
                                        child: SvgIcon(
                                          icon: SvgIconData(
                                              'assets/icons/propertyIcon.svg'),
                                          color: Color(0xFF323E48),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 25),
                                      child: DropdownButton2<PropertyModel>(
                                        underline: Container(),
                                        value: state.selectedProperty,
                                        isExpanded: true,
                                        hint: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Select Property',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily:
                                                      'MontserratRegular',
                                                  color: Color(0xFF323E48),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: state.properties.map((property) {
                                          return DropdownMenuItem(
                                            value: property,
                                            child: Text(
                                              property.propertyName,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'MontserratMedium',
                                                color: Color(0xFF323E48),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          BlocProvider.of<HomeBloc>(context)
                                              .add(SelectedPropertyChanged(
                                                  value!));
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              width: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: DropdownButton2<PropertyModel>(
                                underline: Container(),
                                isExpanded: true,
                                hint: const Row(
                                  children: [
                                    SvgIcon(
                                      icon: SvgIconData(
                                          'assets/icons/dateIcon.svg'),
                                      color: Color(0xFF323E48),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Select Dates',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'MontserratRegular',
                                          color: Color(0xFF323E48),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                items: [],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                              height: 40,
                              width: 163,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: DropdownButton2<PropertyModel>(
                                underline: Container(),
                                isExpanded: true,
                                hint: const Row(
                                  children: [
                                    Icon(
                                      Icons.person_add,
                                      color: Color(0xFF323E48),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Guests & Rooms',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'MontserratRegular',
                                          color: Color(0xFF323E48),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                items: [],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              body: Container(
                color: Color(0xFFF9F9F9),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Text(
                        'Available Properties',
                        style: TextStyle(
                          fontFamily: 'MontserratMedium',
                          fontSize: 16,
                          color: Color(0xFF323E48),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.selectedProperty.availableSpaces.length,
                      itemBuilder: (context, index) {
                        final availableSpaces =
                            state.selectedProperty.availableSpaces[index];
                        return PropertyCard(
                          availableSpaces: availableSpaces,
                          // onPageChanged: (index, p1) {
                          //   BlocProvider.of<HomeBloc>(context)
                          //       .add(SelectedImageChanged(index));
                          // },
                          // dotsCount: state.selectedProperty
                          //     .availableSpaces[index].spaceImages.length,
                          // position: state.index,
                          // // image: state.selectedProperty
                          // //     .availableSpaces[index].spaceImages[index],
                          // itemCount: state.selectedProperty
                          //     .availableSpaces[index].spaceImages.length,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            state.status == FetchPropertStatus.loading
                ? CustomLoadingWidget()
                : SizedBox.shrink(),
          ],
        );
      },
    );
  }
}
