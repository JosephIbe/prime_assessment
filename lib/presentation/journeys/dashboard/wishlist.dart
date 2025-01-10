import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:primed_health/presentation/widgets/empty_state.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {

  late Size size;

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: const Center(
            child: Center(child: EmptyState(title: 'There are no saved items to show',),),
          ),
        ),
      ),
    );
  }

}