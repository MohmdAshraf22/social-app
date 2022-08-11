
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email = TextEditingController();

  var pass = TextEditingController();

  var Formkey = GlobalKey<FormState>();

  bool ispass = true;
  IconData icon = Icons.visibility;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      body : Padding(
        padding: const EdgeInsets.all(20.6),
        child: Form(
          key: Formkey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Login'
                    , style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.purple,
                    ),),
                  SizedBox(height: 30,),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty)
                        {
                          return'email is empty';
                        }
                      return null;
                    } ,
                    controller: email ,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: 'Enter Your Email',
                      prefixIcon: Icon(
                          Icons.email
                      ),
                    ),
                  ),
                  SizedBox(height: 12 ,),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return'pass is empty';
                      }
                      return null;
                    } ,
                    controller: pass,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: ispass ,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular (30),
                      ),
                      labelText: 'Enter Your Password',
                      prefixIcon: Icon(
                          Icons.lock
                      ),
                      suffixIcon:IconButton(
                        icon : Icon(
                            icon,
                        ),
                        onPressed: (){
                          setState(() {
                          if (ispass == false)
                            {
                              ispass = true;
                              icon = Icons.visibility;
                            }
                          else
                            {
                              ispass = false;
                              icon = Icons.visibility_off;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 15 ,),
                  Container(
                    height: 35,
                    width: double.infinity,
                    color: Colors.purple,
                    child: MaterialButton(onPressed: (
                    ){
                      if (Formkey.currentState!.validate()){
                        print(pass.text);
                        print(email.text);
                      }
                      return null;
                    },
                      child: Text('LOGIN',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17
                        ),),
                    ),
                  ),
                  SizedBox(height: 10 ,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t Have Account ?',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),),
                      TextButton(onPressed: (){},
                          child: Text('Register Now',
                            style: TextStyle(
                                color: Colors.purple
                            ),)),

                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
