import 'dart:async';

import 'package:auth_screen/pages/SeeAll.dart';
import 'package:auth_screen/res/lists.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Turmas extends StatefulWidget {
  const Turmas({super.key});

  @override
  State<Turmas> createState() => _TurmasState();
}

class _TurmasState extends State<Turmas> {
  var opacity = 0.0;
  bool position = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();

      setState(() {});
    });
  }

  animator() {
    if (opacity == 1) {
      opacity = 0;
      position = false;
    } else {
      opacity = 1;
      position = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 30, left: 0, right: 0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                top: position ? 1 : 100,
                right: 20,
                left: 20,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Olá!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Helvetica',
                              color: Colors.black.withOpacity(.7),
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            'Edrian',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Helvetica',
                              color: Colors.black.withOpacity(.7),
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                      const Icon(Icons.phonelink_ring)
                    ],
                  ),
                ),
              ),
              AnimatedPositioned(
                  top: 80,
                  right: 20,
                  left: 20,
                  duration: const Duration(milliseconds: 400),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        height: 90,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.blue.shade700,
                                  Colors.blue.shade900,
                                  Colors.blue.shade900,
                                ])),
                        child: Stack(
                          children: [
                            Positioned(
                                top: 10,
                                left: 20,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Center(
                                      child: Image(
                                        width: 70,
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            'assets/icons/check.png'),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Obrigado!',
                                          style: TextStyle(
                                            fontFamily: 'Helvetica',
                                            color: Colors.white,
                                            fontSize:
                                                20, 
                                          ),
                                        ),
                                       
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Mensalidades em dia!',
                                              style: TextStyle(
                                                fontFamily: 'Helvetica',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  )),
              AnimatedPositioned(
                  top: 200,
                  left: 20,
                  right: 20,
                  duration: const Duration(milliseconds: 400),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: opacity,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hoje - 12/04/2024',
                            style: TextStyle(
                              fontFamily: 'Helvetica',
                              color: Colors.black.withOpacity(.8),
                              fontSize: 20,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              animator();
                              setState(() {});
                              // Timer(Duration(seconds: 1),() {
                              //   Navigator.push(context, MaterialPageRoute(builder: (context) => SeeAll(),));
                              //   animator();
                              // },);
                              await Future.delayed(
                                  const Duration(milliseconds: 500));
                              await Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return SeeAll();
                                },
                              ));

                              setState(() {
                                animator();
                              });
                            },
                            child: Text(
                              'ver todas',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Helvetica',
                                color: Colors.blue.shade600.withOpacity(.8),
                                fontSize: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
              doctorList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget doctorList() {
    return AnimatedPositioned(
        top: 240,
        left: 10,
        right: 20,
        duration: const Duration(milliseconds: 400),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: opacity,
          child: AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(milliseconds: 300),
            child: SizedBox(
              height: 350,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    doctorCard(names[0], spacilality[0]),
                   
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget doctorCard(String name, String specialist) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 120,
        width: double.infinity,
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Somente 12 vagas",
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
            const Spacer(),
            const Icon(
              Icons.schedule_sharp,
              color: Colors.blue,
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget category(String asset, String txt, double padding) {
    return Column(
      children: [
        InkWell(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              padding: EdgeInsets.all(padding),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Image(
                  image: AssetImage(asset),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          txt,
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 25,
          ),
        ),
      ],
    );
  }
}
