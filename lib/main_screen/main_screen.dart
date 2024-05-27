import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:direct_unlocker/logic/local.dart';
import 'package:direct_unlocker/logic/logic_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _passwordVisible = false;
  bool value = true;
  final prefs = SharedPreferences.getInstance();

  TextEditingController userNameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passSignupController = TextEditingController();
  TextEditingController emailSignUpController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController creditsController = TextEditingController();

  @override
  void initState() {
    _passwordVisible = false;
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    print(CacheHelper.get(key: "id"));
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.all(20),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.grey, width: 2)),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.all(15),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey, width: 2)),
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 15, right: 15),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: ListView(
                      clipBehavior: Clip.none,
                      children: [
                        Stack(
                          fit: StackFit.passthrough,
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 2)),
                              child: Form(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: 45,
                                      child: TextField(
                                        controller: emailController,
                                        decoration: InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.person_2_outlined,
                                              color: Colors.grey,
                                            ),
                                            hintText: "ENTER YOUR EMAIL",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                borderSide: BorderSide(
                                                    color: Colors.grey)),
                                            fillColor: Colors.white12,
                                            filled: true),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 45,
                                      child: TextField(
                                        controller: passController,
                                        obscureText: _passwordVisible,
                                        decoration: InputDecoration(
                                            hintText: "ENTER Password",
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                // Based on passwordVisible state choose the icon
                                                _passwordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Colors.grey,
                                              ),
                                              onPressed: () {
                                                // Update the state i.e. toogle the state of passwordVisible variable
                                                setState(() {
                                                  _passwordVisible =
                                                      !_passwordVisible;
                                                });
                                              },
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                borderSide: BorderSide(
                                                    color: Colors.grey)),
                                            fillColor: Colors.white12,
                                            filled: true),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ListTile(
                                              contentPadding: EdgeInsets.all(0),
                                              title: const Text('SAVE USER'),
                                              leading: Checkbox(
                                                checkColor: Colors.white,
                                                activeColor: Colors.greenAccent,
                                                value: value,
                                                onChanged: (bool? val) {
                                                  setState(() {
                                                    value = val!;
                                                  });
                                                },
                                              )),
                                        ),
                                        Expanded(
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          AdaptiveTheme.of(
                                                                      context)
                                                                  .mode
                                                                  .isDark
                                                              ? Colors.white24
                                                              : AdaptiveTheme.of(
                                                                          context)
                                                                      .mode
                                                                      .isLight
                                                                  ? Colors
                                                                      .greenAccent
                                                                  : Colors
                                                                      .white12)),
                                              onPressed: () {
                                                Logic().signIn(
                                                    emailController.text,
                                                    passController.text,
                                                    context).then((onValue){

                                                  FirebaseFirestore.instance.collection('Users').get().then((v)async {
                                                    v.docs.forEach((value)async{
                                                      if(value.get("id")==onValue.user !.uid){
                                                        await CacheHelper.put(key: 'id', value:value.get("id"));
                                                        await CacheHelper.put(key:'email',value: value.get("email"));
                                                        await CacheHelper.put(key:'credits',value: value.get("credits"));
                                                        await CacheHelper.put(key:'userName',value: value.get("userName"));
                                                        await CacheHelper.put(key:'phoneNumber',value: value.get("phoneNumber"));
                                                        setState(() {

                                                        });
                                                      }
                                                    });



                                                  });
                                                });
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.login),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text("LOGIN")
                                                  ],
                                                ),
                                              )),
                                        )
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _showSignUpDialog(context);
                                      },
                                      child: const Row(
                                        children: [
                                          Text("Dont have an acount? "),
                                          Text(
                                            "SignUp",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                                top: -17,
                                right: 10,
                                left: 10,
                                child: Image.asset(
                                  "icons/user.png",
                                  height: 50,
                                ))
                          ],
                        ),
                        Container(
                            width: double.infinity,
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 2)),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    DefaultTextStyle(
                                      style: const TextStyle(
                                          color: Colors.purpleAccent,
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold),
                                      child: AnimatedTextKit(
                                        animatedTexts: [
                                          WavyAnimatedText('Direct '),
                                        ],
                                        isRepeatingAnimation: true,
                                        onTap: () {
                                          print("Tap Event");
                                        },
                                      ),
                                    ),
                                    DefaultTextStyle(
                                      style: const TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold),
                                      child: AnimatedTextKit(
                                        animatedTexts: [
                                          WavyAnimatedText('Unlocker'),
                                        ],
                                        isRepeatingAnimation: true,
                                        onTap: () {
                                          print("Tap Event");
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        index = 0;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AdaptiveTheme.of(context)
                                                  .mode
                                                  .isDark
                                              ? Colors.white12
                                              : Colors.black26),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "icons/information.png",
                                            height: 30,
                                          ),
                                          Text("  READ INFO")
                                        ],
                                      ),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        index = 1;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AdaptiveTheme.of(context)
                                                  .mode
                                                  .isDark
                                              ? Colors.white12
                                              : Colors.black26),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "icons/unlocked.png",
                                            height: 30,
                                          ),
                                          Text("  Direct Unlock")
                                        ],
                                      ),
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        index = 2;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AdaptiveTheme.of(context)
                                                  .mode
                                                  .isDark
                                              ? Colors.white12
                                              : Colors.black26),
                                      child:
                                          Center(child: Text("  EM - TOKEN")),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        index = 3;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AdaptiveTheme.of(context)
                                                  .mode
                                                  .isDark
                                              ? Colors.white12
                                              : Colors.black26),
                                      child: Center(child: Text("CSC CHANGE")),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        index = 4;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AdaptiveTheme.of(context)
                                                  .mode
                                                  .isDark
                                              ? Colors.white12
                                              : Colors.black26),
                                      child: const Center(
                                          child: Text(
                                              "KG LOCKED  - ACTIVE REMOVE")),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        index = 5;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AdaptiveTheme.of(context)
                                                  .mode
                                                  .isDark
                                              ? Colors.white12
                                              : Colors.black26),
                                      child: const Center(
                                          child: Text("KNOX  - MDM REMOVE")),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        index = 6;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AdaptiveTheme.of(context)
                                                  .mode
                                                  .isDark
                                              ? Colors.white12
                                              : Colors.black26),
                                      child: Center(child: Text("RESET FRB")),
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            )),
                        Container(
                            width: double.infinity,
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 2)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("USER :  "),
                                    CacheHelper.get(key: "id") == null
                                        ? Container(
                                            color: AdaptiveTheme.of(context)
                                                    .mode
                                                    .isDark
                                                ? Colors.white24
                                                : Colors.black26,
                                            height: 20,
                                            width: 150,
                                          )
                                        : Text(CacheHelper.get(key: "userName"))
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("CRIDTS :  "),  CacheHelper.get(key: "id") == null
                                        ? Container(
                                      color: AdaptiveTheme.of(context)
                                          .mode
                                          .isDark
                                          ? Colors.white24
                                          : Colors.black26,
                                      height: 20,
                                      width: 150,
                                    )
                                        : Text(CacheHelper.get(key: "credits"))

                                  ],
                                )
                              ],
                            )),
                        const SizedBox(height: 50,),
                        CacheHelper.get(key: "id")==null?const SizedBox():
                        GestureDetector(onTap: (){
                          CacheHelper.clearData();
                          emailController.clear();
                          passController.clear();
                          setState(() {

                          });
                        },child: const Row(children: [
                          Icon(Icons.logout,color: Colors.red,),
                          Text("   Logout")
                        ],),)
                      ],
                    )),
                Expanded(
                    flex: 2,
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 5, bottom: 20, right: 15),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2)),
                      child:_buildChildBasedOnIndex(index)
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildChildBasedOnIndex(int index) {
    switch (index) {
      case 0:
        return CacheHelper.get(key: "id")==null?const SizedBox():const Center(child: Text("Hello"));
      case 1:
        return const SizedBox();
      case 3:
        return const SizedBox();
      case 4:
        return const SizedBox();
      case 5:
        return const SizedBox();
      case 6:
        return const SizedBox();
      default:
        return const SizedBox();
    }
  }
  void _showSignUpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Signup'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: userNameController,
                  decoration: const InputDecoration(hintText: 'Full Name'),
                ),
                TextField(
                  controller: emailSignUpController,
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
                TextField(
                  controller: passSignupController,
                  decoration: const InputDecoration(hintText: 'Password'),
                  obscureText: true,
                ),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'phone number'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Signup'),
              onPressed: () {
                Logic()
                    .createUser(
                        emailSignUpController.text,
                        passSignupController.text,
                        userNameController.text,
                        phoneController.text,
                        context)
                    .then((onValue) {
                  emailSignUpController.clear();
                  passSignupController.clear();
                  userNameController.clear();
                  phoneController.clear();
                });
                // Handle the signup logic
              },
            ),
          ],
        );
      },
    );
  }
}
