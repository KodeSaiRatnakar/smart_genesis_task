import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_app/bloc/productbloc.dart';
import 'package:practice_app/bloc/productevent.dart';
import 'package:practice_app/bloc/productstate.dart';
import 'package:practice_app/productdetailscreen.dart';

import 'modelclass.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  static String route = "Home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> list = [];
  List<Product> sortedList = [];
  bool sorted = false;

  void sortByPrice(List<Product> list) {
    List<double> price = [];

    for (int i = 0; i < list.length; i++) {
      price.add(double.parse(list[i].price));
    }

    price.sort();

    for (int i = 0; i < price.length; i++) {
      for (int j = 0; j < price.length; j++) {
        if (list[j].price == price[i].toString()) {
          sortedList.add(list[j]);
          continue;
        }
      }
    }
    sorted = sorted ? false : true;
    setState(() {
      list = sortedList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              showSearch(context: context, delegate: Search(list: list));
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.91,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0XffF637EC), width: 2)),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.search,
                    color: Color(0XFF8C00FF),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Search for Products",
                    style: TextStyle(
                        color: Color(0XFF8C00FF),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width * 0.91,
            decoration: BoxDecoration(
                color: Color(0xffB1AFFF),
                borderRadius: BorderRadius.circular(5)),
            child: SizedBox(
              height: 45,
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Products",
                    style: TextStyle(
                        color: Color(0XFF8C00FF), fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        "Sort by Price",
                        style: TextStyle(color: Color(0XFF8C00FF)),
                      ),
                      Switch(
                          activeColor: Color(0XFF8C00FF),
                          value: sorted,
                          onChanged: (value) {
                            if (list.isNotEmpty) {
                              sortByPrice(list);
                            }
                          })
                    ],
                  ),
                ],
              ),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
              height: MediaQuery.of(context).size.height >
                      MediaQuery.of(context).size.width
                  ? MediaQuery.of(context).size.height * 0.75
                  : MediaQuery.of(context).size.height * 0.5,
              child: BlocProvider(
                create: (context) => ProductBloc()..add(LoadEvent()),
                child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                  if (state is ProductErrorState) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                          "Something Went Wrong",
                          style: TextStyle(
                              color: Color(0XFF8C00FF),
                              fontWeight: FontWeight.bold),
                        )),
                        SizedBox(
                          height: 20,
                        ),
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<ProductBloc>(context)
                                  .add(LoadEvent());
                            },
                            icon: Icon(
                              Icons.refresh,
                              color: Color(0XFF8C00FF),
                            ))
                      ],
                    );
                  }
                  if (state is ProductLoadingState) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Color(0XFF8C00FF),
                    ));
                  }
                  if (state is ProductLoadedState) {
                    list = state.list;
                  }

                  if (sorted) {
                    list = sortedList;
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                        width: double.infinity,
                        child: ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailScreen(product: list[index])));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20.0, right: 8, left: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.4),
                                            spreadRadius: 3,
                                            blurRadius: 5,
                                            offset: const Offset(3,
                                                6), // changes position of shadow
                                          ),
                                        ],
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0XFF8C00FF),
                                            Color(0XffF637EC)
                                          ],
                                          end: Alignment.bottomRight,
                                          begin: Alignment.topCenter,
                                        ),
                                        border: Border.all(
                                            width: 0.0,
                                            color: Colors.black.withOpacity(0.1)),
                                        borderRadius: BorderRadius.circular(12)),
                                    child: Column(children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        width: MediaQuery.of(context).size.width *
                                            0.6,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    list[index].image))),
                                      ),
                                      FittedBox(
                                          child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${list[index]
                                                  .description
                                                  .substring(0, 60)}...",
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      )),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          list[index].title,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Container(
                                          width: 45,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  list[index]
                                                      .rating["rate"]
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                               const Icon(
                                                  Icons.star,
                                                  color: Colors.white,
                                                  size: 15,
                                                )
                                              ],
                                            ),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Price : ₹${list[index].price}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              );
                            })),
                  );
                }),
              )),
        )
      ]),
    );
  }
}

class Search extends SearchDelegate {
  final List<Product> list;
  bool isNoResult = false;

  Search({required this.list});

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
          color: Colors.white,
          iconTheme: Theme.of(context).iconTheme.copyWith(
                color: const Color(0XFF8C00FF),
              )),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          query = "";

          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
if(index == 0){
  isNoResult = false;
}
            if (!list[index]
                .title
                .toLowerCase()
                .startsWith(query.toLowerCase())) {


              if (index == list.length - 1 && !isNoResult ) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                   const Center(
                      child: Text(
                        "Result's Not Found",
                        style: TextStyle(
                          color: Color(0XFF8C00FF),
                        ),
                      ),
                    )
                  ],
                );
              }
              return Container();
            }

            isNoResult = true;

            return InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProductDetailScreen(product: list[index])));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color:const Color(0xffC47AFF),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(children: [
                   const  SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 200,
                      width: 250,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(list[index].image))),
                    ),
                    FittedBox(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${list[index].description.substring(0, 60)}...",
                        style: const TextStyle(color: Colors.white),
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        list[index].title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                        width: 45,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Text(
                                list[index].rating["rate"].toString(),
                                style:const TextStyle(color: Colors.white),
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 15,
                              )
                            ],
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Price : ₹${list[index].price}"),
                    ),
                  ]),
                ),
              ),
            );
          });
    }

    return const Center(
        child: Text(
      "No Results Found",
      style: TextStyle(
        color: Color(0XFF8C00FF),
      ),
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          if (!list[index].title.toLowerCase().startsWith(query)) {




            return Container();
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProductDetailScreen(product: list[index])));
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xff85F4FF),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      list[index].title.substring(0, 10),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    )),
                  )),
            ),
          );
        });

  }

}
