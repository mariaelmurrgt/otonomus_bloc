import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import 'package:otonomus/business_logic/blocs.dart';
import 'package:otonomus/data/models/property_model.dart';

class PropertyCard extends StatefulWidget {
  final AvailableSpace availableSpaces;
  // final Function(int, CarouselPageChangedReason)? onPageChanged;
  // final int dotsCount;
  // final int position;
  // final int itemCount;
  // // final String image;
  const PropertyCard({
    required this.availableSpaces,
    // this.onPageChanged,
    // this.dotsCount = 0,
    // this.position = 0,
    // this.itemCount = 0,
    // // required this.image,
  });

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  @override
  int _currentIndex = 0;

  void didUpdateWidget(covariant PropertyCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.availableSpaces.spaceImages.length);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Card(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CarouselSlider.builder(
                      itemCount:
                          //widget.itemCount,
                          widget.availableSpaces.spaceImages.length,
                      itemBuilder: (context, index, realIndex) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            //widget.image,
                            widget.availableSpaces.spaceImages[index],
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                      options: CarouselOptions(
                        aspectRatio: 13 / 9,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: false,
                        reverse: false,
                        onPageChanged:
                            //widget.onPageChanged,
                            (index, reason) {
                          // BlocProvider.of<HomeBloc>(context)
                          //     .add(SelectedImageChanged(index));
                          // print(state.index);
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 0,
                      right: 0,
                      child: DotsIndicator(
                        dotsCount:
                            //widget.dotsCount,
                            widget.availableSpaces.spaceImages.length,
                        position:
                            //widget.position,
                            _currentIndex,
                        decorator: DotsDecorator(
                          size: Size.square(6),
                          activeSize: Size.square(10),
                          color: Colors.grey,
                          activeColor: Colors.white,
                          spacing: EdgeInsets.all(4),
                          activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${widget.availableSpaces.propertyName}',
                  style: TextStyle(
                    color: Color(0xFF607385),
                    fontFamily: 'MontserratRegular',
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${widget.availableSpaces.spaceTitle}',
                        style: TextStyle(
                          color: Color(0xFF3C4955),
                          fontFamily: 'MontserratMedium',
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgIcon(
                            icon: SvgIconData('assets/icons/starIcon.svg'),
                            color: Colors.yellow,
                          ),
                          SizedBox(width: 2),
                          Text('${widget.availableSpaces.spaceRating}'),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${widget.availableSpaces.spaceDescription}',
                        style: TextStyle(
                          color: Color(0xFF607385),
                          fontFamily: 'MontserratRegular',
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF297BE6),
                          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Starting Price',
                              style: TextStyle(
                                fontFamily: 'MontserratRegular',
                                color: Colors.white,
                                fontSize: 8,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              '\$${widget.availableSpaces.spacePrice}/night',
                              style: TextStyle(
                                fontFamily: 'MontserratMedium',
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
