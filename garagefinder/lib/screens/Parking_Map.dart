import 'package:flutter/material.dart';
// import 'package:grouped_list/grouped_list.dart';

class ParkingMap extends StatefulWidget {
  const ParkingMap({super.key});

  @override
  State<StatefulWidget> createState() => _ParkingMap();
}

class _ParkingMap extends State<ParkingMap> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        width: 360,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 62),
          child: Stack(
            children: [
              Positioned(
                left: 12,
                width: 336,
                top: 1090,
                height: 1,
                child: Container(
                  width: 336,
                  height: 1,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0x19000000), width: 1),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                width: 336,
                top: 1166,
                height: 1,
                child: Container(
                  width: 336,
                  height: 1,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0x19000000), width: 1),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                width: 360,
                top: 1232,
                child: Container(
                  width: 360,
                  decoration: const BoxDecoration(
                    color: Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x1e000000),
                          offset: Offset(0, 0),
                          blurRadius: 6),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 28,
                                  height: 28,
                                  child: Text(
                                    '🗺️',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 20,
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.normal),
                                    maxLines: 9999,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 14,
                                        child: Text(
                                          'Map',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 10,
                                              color: Color(0xff000000),
                                              fontWeight: FontWeight.normal),
                                          maxLines: 9999,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 28,
                                  height: 28,
                                  child: Text(
                                    '🚗',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 20,
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.normal),
                                    maxLines: 9999,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 14,
                                        child: Text(
                                          'Parking',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 10,
                                              color: Color(0xff000000),
                                              fontWeight: FontWeight.normal),
                                          maxLines: 9999,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 28,
                                  height: 28,
                                  child: Text(
                                    '🔍',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 20,
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.normal),
                                    maxLines: 9999,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 14,
                                        child: Text(
                                          'Search',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 10,
                                              color: Color(0xff000000),
                                              fontWeight: FontWeight.normal),
                                          maxLines: 9999,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                width: 360,
                top: 0,
                child: Container(
                  width: 360,
                  decoration: const BoxDecoration(
                    color: Color(0xffffffff),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 0, top: 0, right: 0, bottom: 62),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xffffffff),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0x1e000000),
                                        offset: Offset(0, 0),
                                        blurRadius: 6),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Image.asset(
                                              '../../lambo.jpg',
                                              height: 24,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8,
                                                  top: 12,
                                                  right: 8,
                                                  bottom: 12),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    '../../ducati.jpg',
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  const Expanded(
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      child: Text(
                                                        'CSUN Parking Map',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontSize: 20,
                                                            color: Color(
                                                                0xff000000),
                                                            fontFamily:
                                                                'Roboto-Medium',
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                        maxLines: 9999,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, top: 16, right: 12, bottom: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: const Color(0x19000000),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: const Text(
                                                        'CSUN Parking',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontSize: 16,
                                                            color: Color(
                                                                0xff000000),
                                                            fontFamily:
                                                                'Roboto-Medium',
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: const Text(
                                                        'Parking Structures Map',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontSize: 12,
                                                            color: Color(
                                                                0x7f000000),
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 336,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, top: 0, right: 12, bottom: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color(0x0c000000),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                width: 336,
                                                top: 0,
                                                height: 336,
                                                child: Image.asset(
                                                  'images/image1_2001287.png',
                                                  width: 336,
                                                  height: 336,
                                                ),
                                              ),
                                              Positioned(
                                                left: 8,
                                                width: 336,
                                                top: 0,
                                                height: 336,
                                                child: Image.asset(
                                                  'images/image2_2001290.png',
                                                  width: 336,
                                                  height: 336,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              const Positioned(
                                                left: 16,
                                                right: 16,
                                                top: 176,
                                                child: Text(
                                                  'Map showing parking structures at CSUN',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontSize: 16,
                                                      color: Color(0xff000000),
                                                      fontFamily:
                                                          'Roboto-Medium',
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  maxLines: 9999,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Positioned(
                                                left: 156,
                                                width: 24,
                                                top: 144,
                                                height: 24,
                                                child: Image.asset(
                                                  'images/image3_2001292.png',
                                                  width: 24,
                                                  height: 24,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, top: 0, right: 12, bottom: 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xffffffff),
                                                border: Border.all(
                                                    color:
                                                        const Color(0xff000000),
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 12,
                                                    top: 10,
                                                    right: 12,
                                                    bottom: 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Filter Map',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xff000000),
                                                          fontFamily:
                                                              'Roboto-Medium',
                                                          fontWeight: FontWeight
                                                              .normal),
                                                      maxLines: 9999,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xffffffff),
                                                border: Border.all(
                                                    color:
                                                        const Color(0xff000000),
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 12,
                                                    top: 10,
                                                    right: 12,
                                                    bottom: 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Share Map',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xff000000),
                                                          fontFamily:
                                                              'Roboto-Medium',
                                                          fontWeight: FontWeight
                                                              .normal),
                                                      maxLines: 9999,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xff000000),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 12,
                                                    top: 10,
                                                    right: 12,
                                                    bottom: 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Navigate to CSUN',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xffffffff),
                                                          fontFamily:
                                                              'Roboto-Medium',
                                                          fontWeight: FontWeight
                                                              .normal),
                                                      maxLines: 9999,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, top: 0, right: 12, bottom: 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0,
                                                    top: 16,
                                                    right: 0,
                                                    bottom: 0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: SizedBox(
                                                        width: double.infinity,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    child:
                                                                        const Text(
                                                                      'Parking Structures',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: TextStyle(
                                                                          decoration: TextDecoration
                                                                              .none,
                                                                          fontSize:
                                                                              18,
                                                                          color: Color(
                                                                              0xff000000),
                                                                          fontFamily:
                                                                              'Roboto-Medium',
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                      maxLines:
                                                                          9999,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: const Color(
                                                                0x19000000),
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: SizedBox(
                                                                  height: 164,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            color:
                                                                                Color(0x0c000000),
                                                                          ),
                                                                          child:
                                                                              Stack(
                                                                            children: [
                                                                              const Positioned(
                                                                                left: 16,
                                                                                right: 16,
                                                                                top: 74,
                                                                                height: 16,
                                                                                child: Text(
                                                                                  'Image of parking structure',
                                                                                  textAlign: TextAlign.center,
                                                                                  style: TextStyle(decoration: TextDecoration.none, fontSize: 12, color: Color(0xff000000), fontWeight: FontWeight.normal),
                                                                                  maxLines: 9999,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                ),
                                                                              ),
                                                                              Positioned(
                                                                                left: 0,
                                                                                top: 0,
                                                                                child: Container(
                                                                                  decoration: const BoxDecoration(
                                                                                    color: Color(0x0c000000),
                                                                                  ),
                                                                                  child: const Padding(
                                                                                    padding: EdgeInsets.all(4),
                                                                                    child: Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      children: [
                                                                                        Text(
                                                                                          'Open',
                                                                                          textAlign: TextAlign.left,
                                                                                          style: TextStyle(decoration: TextDecoration.none, fontSize: 12, color: Color(0xff000000), fontFamily: 'Roboto-Medium', fontWeight: FontWeight.normal),
                                                                                          maxLines: 9999,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: Container(
                                                                                child: const Text(
                                                                                  'Parking Structure A',
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(decoration: TextDecoration.none, fontSize: 12, color: Color(0xff000000), fontWeight: FontWeight.normal),
                                                                                  maxLines: 9999,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                4),
                                                                        Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: Container(
                                                                                child: const Text(
                                                                                  'Capacity: 500',
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(decoration: TextDecoration.none, fontSize: 16, color: Color(0xff000000), fontFamily: 'Roboto-Medium', fontWeight: FontWeight.normal),
                                                                                  maxLines: 9999,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                4),
                                                                        Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: Container(
                                                                                child: const Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: 24,
                                                                                      height: 24,
                                                                                      child: Text(
                                                                                        '🚗',
                                                                                        textAlign: TextAlign.center,
                                                                                        style: TextStyle(decoration: TextDecoration.none, fontSize: 16, color: Color(0xff000000), fontWeight: FontWeight.normal),
                                                                                        maxLines: 9999,
                                                                                        overflow: TextOverflow.ellipsis,
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
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: const Color(
                                                                0x19000000),
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: SizedBox(
                                                                  height: 164,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            color:
                                                                                Color(0x0c000000),
                                                                          ),
                                                                          child:
                                                                              Stack(
                                                                            children: [
                                                                              const Positioned(
                                                                                left: 16,
                                                                                right: 16,
                                                                                top: 74,
                                                                                height: 16,
                                                                                child: Text(
                                                                                  'Image of parking structure',
                                                                                  textAlign: TextAlign.center,
                                                                                  style: TextStyle(decoration: TextDecoration.none, fontSize: 12, color: Color(0xff000000), fontWeight: FontWeight.normal),
                                                                                  maxLines: 9999,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                ),
                                                                              ),
                                                                              Positioned(
                                                                                left: 0,
                                                                                top: 0,
                                                                                child: Container(
                                                                                  decoration: const BoxDecoration(
                                                                                    color: Color(0x0c000000),
                                                                                  ),
                                                                                  child: const Padding(
                                                                                    padding: EdgeInsets.all(4),
                                                                                    child: Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      children: [
                                                                                        Text(
                                                                                          'Full',
                                                                                          textAlign: TextAlign.left,
                                                                                          style: TextStyle(decoration: TextDecoration.none, fontSize: 12, color: Color(0xff000000), fontFamily: 'Roboto-Medium', fontWeight: FontWeight.normal),
                                                                                          maxLines: 9999,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: Container(
                                                                                child: const Text(
                                                                                  'Parking Structure B',
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(decoration: TextDecoration.none, fontSize: 12, color: Color(0xff000000), fontWeight: FontWeight.normal),
                                                                                  maxLines: 9999,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                4),
                                                                        Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: Container(
                                                                                child: const Text(
                                                                                  'Capacity: 300',
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(decoration: TextDecoration.none, fontSize: 16, color: Color(0xff000000), fontFamily: 'Roboto-Medium', fontWeight: FontWeight.normal),
                                                                                  maxLines: 9999,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                4),
                                                                        Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: Container(
                                                                                child: const Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: 24,
                                                                                      height: 24,
                                                                                      child: Text(
                                                                                        '🚗',
                                                                                        textAlign: TextAlign.center,
                                                                                        style: TextStyle(decoration: TextDecoration.none, fontSize: 16, color: Color(0xff000000), fontWeight: FontWeight.normal),
                                                                                        maxLines: 9999,
                                                                                        overflow: TextOverflow.ellipsis,
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
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
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
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, top: 0, right: 12, bottom: 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0,
                                                    top: 16,
                                                    right: 0,
                                                    bottom: 0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: SizedBox(
                                                        width: double.infinity,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    child:
                                                                        const Text(
                                                                      'Additional Info',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: TextStyle(
                                                                          decoration: TextDecoration
                                                                              .none,
                                                                          fontSize:
                                                                              18,
                                                                          color: Color(
                                                                              0xff000000),
                                                                          fontFamily:
                                                                              'Roboto-Medium',
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                      maxLines:
                                                                          9999,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0,
                                                    top: 12,
                                                    right: 0,
                                                    bottom: 12),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 32,
                                                      height: 32,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0x0c000000),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                      ),
                                                      child: const Stack(
                                                        children: [
                                                          Positioned(
                                                            left: 0,
                                                            width: 32,
                                                            top: 0,
                                                            height: 32,
                                                            child: Text(
                                                              'ℹ️',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  fontSize: 20,
                                                                  color: Color(
                                                                      0xff000000),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                              maxLines: 9999,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                      child: SizedBox(
                                                        width: double.infinity,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    child:
                                                                        const Text(
                                                                      'Parking Rates',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: TextStyle(
                                                                          decoration: TextDecoration
                                                                              .none,
                                                                          fontSize:
                                                                              14,
                                                                          color: Color(
                                                                              0xff000000),
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                      maxLines:
                                                                          9999,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    child:
                                                                        const Text(
                                                                      'Rates vary based on duration',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: TextStyle(
                                                                          decoration: TextDecoration
                                                                              .none,
                                                                          fontSize:
                                                                              12,
                                                                          color: Color(
                                                                              0x7f000000),
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                      maxLines:
                                                                          9999,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    const SizedBox(
                                                      width: 91,
                                                      child: Text(
                                                        'Check CSUN website for details',
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xff000000),
                                                            fontFamily:
                                                                'Roboto-Medium',
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                        maxLines: 9999,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: 24,
                                                          height: 24,
                                                          child: Text(
                                                            'ℹ️',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontSize: 16,
                                                                color: Color(
                                                                    0xff000000),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                            maxLines: 9999,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        SizedBox(width: 8),
                                                        SizedBox(
                                                          width: 24,
                                                          height: 24,
                                                          child: Text(
                                                            '🅿️',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontSize: 16,
                                                                color: Color(
                                                                    0xff000000),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                            maxLines: 9999,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0,
                                                    top: 12,
                                                    right: 0,
                                                    bottom: 12),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 32,
                                                      height: 32,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0x0c000000),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                      ),
                                                      child: const Stack(
                                                        children: [
                                                          Positioned(
                                                            left: 0,
                                                            width: 32,
                                                            top: 0,
                                                            height: 32,
                                                            child: Text(
                                                              '🅿️',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  fontSize: 20,
                                                                  color: Color(
                                                                      0xff000000),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                              maxLines: 9999,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                      child: SizedBox(
                                                        width: double.infinity,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    child:
                                                                        const Text(
                                                                      'Accessible Parking',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: TextStyle(
                                                                          decoration: TextDecoration
                                                                              .none,
                                                                          fontSize:
                                                                              14,
                                                                          color: Color(
                                                                              0xff000000),
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                      maxLines:
                                                                          9999,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    child:
                                                                        const Text(
                                                                      'Designated spots available',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: TextStyle(
                                                                          decoration: TextDecoration
                                                                              .none,
                                                                          fontSize:
                                                                              12,
                                                                          color: Color(
                                                                              0x7f000000),
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                      maxLines:
                                                                          9999,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    const SizedBox(
                                                      width: 91,
                                                      child: Text(
                                                        'Near main entrances',
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xff000000),
                                                            fontFamily:
                                                                'Roboto-Medium',
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                        maxLines: 9999,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: 24,
                                                          height: 24,
                                                          child: Text(
                                                            'ℹ️',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontSize: 16,
                                                                color: Color(
                                                                    0xff000000),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                            maxLines: 9999,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        SizedBox(width: 8),
                                                        SizedBox(
                                                          width: 24,
                                                          height: 24,
                                                          child: Text(
                                                            '🅿️',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontSize: 16,
                                                                color: Color(
                                                                    0xff000000),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                            maxLines: 9999,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, top: 0, right: 12, bottom: 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xff000000),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 12,
                                                    top: 10,
                                                    right: 12,
                                                    bottom: 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Find My Car',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xffffffff),
                                                          fontFamily:
                                                              'Roboto-Medium',
                                                          fontWeight: FontWeight
                                                              .normal),
                                                      maxLines: 9999,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
