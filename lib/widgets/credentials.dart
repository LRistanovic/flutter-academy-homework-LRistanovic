import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../state_provider.dart';

class Credentials extends StatelessWidget {
  const Credentials({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
              alignment: Alignment.centerLeft,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                Text('Login', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
                Text('In order to continue please log in.',
                    style: TextStyle(color: Colors.white), textAlign: TextAlign.left),
              ])),
          Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: TextField(
                obscureText: false,
                autocorrect: false,
                style: TextStyle(color: Colors.white),
                onChanged: (String val) {
                  StateProvider provider = Provider.of<StateProvider>(context, listen: false);
                  provider.email = val;
                },
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                    hoverColor: Colors.white),
              )),
          Container(
              child: Consumer<StateProvider>(
                  builder: (context, provider, _) => TextField(
                        obscureText: !provider.isVisible,
                        autocorrect: false,
                        style: const TextStyle(color: Colors.white),
                        onChanged: (String val) {
                          provider.password = val;
                        },
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1)),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
                            labelText: 'Password',
                            errorStyle: TextStyle(color: Colors.red),
                            labelStyle: TextStyle(color: Colors.white),
                            suffixIcon: IconButton(
                              icon: provider.isVisible
                                  ? SvgPicture.asset('assets/images/visible.svg')
                                  : SvgPicture.asset('assets/images/obscured.svg'),
                              onPressed: provider.changeVisibility,
                            )),
                      )))
        ]));
  }
}
