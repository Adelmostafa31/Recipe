import 'package:flutter/material.dart';
import 'package:food/models/food_Model/food_Model.dart';
import 'package:food/shared/styles/colors.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
class DessertDetails extends StatelessWidget {

   List<foodModel> model;
   int? index;
   DessertDetails({required this.model,required this.index});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SlidingUpPanel(
        maxHeight: (size.height/1.2),
        minHeight: (size.height/2.5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        margin: EdgeInsets.symmetric(horizontal: 5),
        // backdropOpacity: 25,
        parallaxEnabled: true,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional.topCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                  child: Image(
                    image: NetworkImage(model[index!].imagePath!),
                    fit: BoxFit.cover,
                    height: (size.height/2)+120,
                    width: double.infinity,
                  ),
                ),
              ),
              Positioned(
                top: 60,
                left: 10,
                child: IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new_rounded,size: 40,color: defualtColor(),)
                ),
              ),
            ],
          ),
        ),
        panel: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 7,
                  width: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: defualtColor()
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text(
                '- '+model[index!].title!,
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10,),
              Text(
                '- '+model[index!].discription!,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Divider(),
              Text(
                '- INGREDIENTS',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold
                ),
              ),
              Divider(),
              Expanded(child: INGREDIENTS(model[index!].recipe))

            ],
          ),
        ),
      ),
    );
  }
  Widget INGREDIENTS(List<dynamic> model)=>
      SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                    return Text(
                      '- '+model[index],
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold
                      ),
                    );
                  },
                  separatorBuilder: (context,index)=>Divider(),
                  itemCount: model.length
              )
            ],
          )
      );
}