import 'package:flutter/material.dart';
import 'package:practice_app/modelclass.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({required this.product, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(3, 6), // changes position of shadow
              ),
            ],
            gradient: const LinearGradient(
              colors: [Color(0XFF8C00FF), Color(0XffF637EC)],
              end: Alignment.bottomRight,
              begin: Alignment.topCenter,
            ),
            border:
                Border.all(width: 0.0, color: Colors.black.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(12)),
        child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {

                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back))
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            height: MediaQuery.of(context).size.width >
                    MediaQuery.of(context).size.height
                ? MediaQuery.of(context).size.height * 0.2
                : MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    fit: BoxFit.fill, image: NetworkImage(product.image))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.description,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              const Text(
                "Rating : ",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Container(
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4)),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${product.rating["rate"].toString()}/5.0",
                          style: const TextStyle(color: Colors.white),
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 15,
                        ),
                      ],
                    ),
                  )),
             const SizedBox(
                width: 10,
              ),
              Text(
                "Out of ${product.rating['count'].toString()} Reviews",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              )
            ],
          ),
          Row(
            children: [
             const SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Price : ₹${product.price}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              const Spacer()
            ],
          ),
        ]),
      ),
    );
  }
}
