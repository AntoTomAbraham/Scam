import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddFood extends StatefulWidget {
  AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final List<String> foodItems = [
    "(1/2 cup ice cream)",
    "(cornstarch)",
    "3 teaspoons sugar",
    "9\" diam. pie",
    "Almonds",
    "Apple betty",
    "Apple juice canned",
    "Apple vinegar",
    "Apples raw",
    "Apricots",
    "Artichoke",
    "Asparagus",
    "Avocado",
    "Bacon",
    "Baked with cheese",
    "Banana",
    "Bean soups",
    "Bean sprouts",
    "Beans",
    "Beef",
    "Beef soup",
    "Beer",
    "Beet greens",
    "Biscuits",
    "Blackberries",
    "Blueberries",
    "Bouillon",
    "Bran flakes",
    "Brazil nuts",
    "Bread cracked wheat",
    "Bread pudding",
    "Broccoli",
    "Brown firm-packed dark sugar",
    "Brussels sprouts",
    "Butter",
    "Butter",
    "Butter",
    "Buttermilk",
    "Cakes",
    "Candied",
    "Candy",
    "Cane Syrup",
    "Cantaloupe",
    "Carbonated drinks Artificially sweetened",
    "Carrots",
    "Cashews",
    "Cauliflower",
    "Celery",
    "Chard steamed",
    "Cheddar",
    "Cheddar grated cup",
    "Cheese",
    "Cherries",
    "Cherry Pie",
    "Chicken livers fried",
    "Chocolate creams",
    "Chocolate fudge",
    "Chocolate syrup",
    "Clam chowder",
    "Clams",
    "Club soda",
    "Cocoa",
    "Cod",
    "Coffee",
    "Cola drinks",
    "Collards",
    "Converted",
    "Corn",
    "Corn bread ground meal",
    "Corn grits cooked",
    "Corn meal",
    "Corn oil",
    "Corned beef",
    "Corned beef hash Dried",
    "Corned beef hash Stew",
    "Corned beef hash canned",
    "Cornflakes",
    "Cows' milk",
    "Crab meat",
    "Crackers",
    "Cranberry sauce sweetened",
    "Cream cheese",
    "Cream or half-and-half",
    "Cream soups",
    "Cucumbers",
    "Cupcake",
    "Custard",
    "Custard",
    "Dandelion greens",
    "Dates",
    "Doughnuts",
    "Dried uncooked",
    "Duck domestic",
    "Eggplant",
    "Eggs Scrambled or fried",
    "Eggs raw",
    "Endive",
    "European as Muscat Tokay",
    "Evaporated undiluted",
    "Farina",
    "Figs",
    "Fish sticks fried",
    "Flounder",
    "Flour",
    "Fortified milk",
    "French dressing",
    "French-fried",
    "Fresh",
    "Fresh raw",
    "Fresh raw",
    "Fresh raw figs",
    "Fresh steamed peas",
    "Fried breast or leg and thigh chicken",
    "Frozen ",
    "Fruit cake",
    "Fruit cocktail canned",
    "Fruit-flavored soda",
    "Fudge",
    "Gelatin made with water",
    "Gin",
    "Ginger ale",
    "Gingerbread",
    "Goats' milk",
    "Grape juice",
    "Grapefruit fresh 5\" diameter",
    "Grapefruit juice",
    "Grapefruit sections",
    "Grapes",
    "Ground lean",
    "Haddock",
    "Halibut",
    "Ham as ",
    "Ham canned spiced",
    "Ham pan-broiled",
    "Hamburger",
    "Hard candies",
    "Herring",
    "Honey",
    "Hydrogenated cooking fat",
    "Ice cream",
    "Ice cream",
    "Ice milk",
    "Iceberg",
    "Ices",
    "Jellies",
    "Kale",
    "Kohlrabi",
    "Lamb chop broiled",
    "Lambs quarters steamed",
    "Lard",
    "Leg roasted",
    "Lemon juice",
    "Lemon meringue",
    "Lemonade concentratefrozen",
    "Lentils",
    "Lettuce",
    "Lima",
    "Lima dry cooked",
    "Limeade concentrate frozen",
    "Lobster",
    "Macaroni",
    "Mackerel",
    "Margarine",
    "Margarine 2 pat or",
    "Marshmallows",
    "Mayonnaise",
    "Milk chocolate",
    "Milk skim",
    "Mince",
    "Molasses",
    "Muffins",
    "Mushrooms canned",
    "Mustard greens",
    "Navy baked with pork",
    "Nectar or juice",
    "Noodle",
    "Noodles",
    "Oatmeal",
    "Okra",
    "Olive oil",
    "Olives large",
    "OlivesRipe",
    "Onions",
    "Orange juice",
    "Oranges 3\" diameter",
    "Oyster stew",
    "Oysters",
    "Pancakes 4\" diam.",
    "Papaya",
    "Parsley",
    "Parsnips",
    "Peaches",
    "Peanut butter",
    "Peanut butter natural",
    "Peanuts",
    "Pears",
    "Peas",
    "Pecans",
    "Peppers Raw green sweet",
    "Peppers canned",
    "Peppers with beef and crumbs",
    "Persimmons",
    "Pineapple",
    "Pineapple Crushed",
    "Pineapple juice",
    "Pizza 14\" diam.",
    "Plain with no icing",
    "Plums",
    "Popcorn salted",
    "Pork chop 1 thick",
    "Pork roast",
    "Pork sausage",
    "Pot-pie",
    "Potato chips",
    "Potatoes Mashed with milk and butter",
    "Potatoes baked",
    "Potatoes pan-tried",
    "Powdered milk",
    "Processed cheese",
    "Prune juice",
    "Prunes",
    "Puddings Sugar",
    "Puffed rice",
    "Puffed wheat presweetened",
    "Pumpkin Pie",
    "Radishes",
    "Raisins",
    "Raspberries",
    "Raw",
    "Raw 2 by 2 1/2",
    "Raw 2\" diameter",
    "Raw 3 by 2V",
    "Raw diced",
    "Raw grated",
    "Raw green",
    "Raw red",
    "Red kidney",
    "Rhubarb sweetened",
    "Rice",
    "Rice flakes",
    "Rice polish",
    "Roast",
    "Roast beef",
    "Roasted chicken",
    "Rolls",
    "Root beer",
    "Roquefort type",
    "Rutabagas",
    "Rye",
    "Safflower seed oil",
    "Salmon",
    "Sardines",
    "Sauerkraut",
    "Scalloped with cheese potatoes",
    "Scallops",
    "Sesame seeds",
    "Shad",
    "Shoulder braised",
    "Shredded wheat biscuit",
    "Shrimp",
    "Soda 2 1/2 square",
    "Soybeans",
    "Spaghetti with meat sauce",
    "Spanish rice",
    "Spinach",
    "Split cooked peas",
    "Split-pea soup",
    "Sponge cake",
    "Squash",
    "Stalk raw",
    "Steak",
    "Steak lean as round",
    "Steamed cabbage",
    "Steamed potatoes before peeling",
    "Stewed or canned",
    "Strawberries",
    "Strips from raw",
    "Sunflower seeds",
    "Sweet potatoes",
    "Swiss",
    "Swordfish",
    "Syrup",
    "Table (12.2% alcohol)",
    "Tangerines",
    "Tapioca cream pudding",
    "Tea",
    "Thousand Island sauce",
    "Tomato catsup",
    "Tomato juice",
    "Tomato soup",
    "Tomatoes",
    "Tuna",
    "Turkey",
    "Turnip greens",
    "Turnips steamed",
    "Veal",
    "Vegetable",
    "Waffles",
    "Walnuts",
    "Watercress stems raw",
    "Watermelon",
  ];
  var grams = [
    "Food",
    "Transport",
    "Personal",
    "Shopping",
    "Medical",
    "Rent",
    "Movie",
    "Salary"
  ];
  String selectedCategory = "";
  String selectedGrams = "";
  TextEditingController gramController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        child: Padding(
          padding: const EdgeInsets.all(21.0),
          child: Column(
            children: [
              const SizedBox(height: 100),
              Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      child: Text(
                    "Today you had!",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.purple,
                    ),
                  ))),
              SizedBox(
                height: 100,
                child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('consumed')
                      .where('email',
                          isEqualTo: FirebaseAuth.instance.currentUser!.email)
                      .where('time',
                          isGreaterThan:
                              DateTime.now().subtract(const Duration(days: 1)))
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      if (snapshot.data!.docs.isEmpty) {
                        return const SizedBox();
                      }
                      return Container(
                          height: 90,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Chip(
                                  label:
                                      Text(snapshot.data!.docs[index]['name'])),
                            ),
                          ));
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      child: Text(
                    "Pick the food",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.purple,
                    ),
                  ))),
              Container(
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color(0xffDFCCFB),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
                child: DropdownButton<String>(
                  items: foodItems.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: Text(selectedCategory.isEmpty
                      ? 'Category Food'
                      : selectedCategory),
                  borderRadius: BorderRadius.circular(10),
                  underline: const SizedBox(),
                  isExpanded: true,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedCategory = value;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      child: Text(
                    "Pick the grams",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.purple,
                    ),
                  ))),
              TextField(
                controller: gramController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Type in your text",
                  fillColor: Colors.white70,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              FadeInUp(
                  duration: const Duration(milliseconds: 1600),
                  child: MaterialButton(
                    onPressed: () async {
                      var data = await FirebaseFirestore.instance
                          .collection('Food_Table')
                          .doc(selectedCategory.replaceAll(' ', '_'))
                          .get();
                      var gm = data['Grams'];
                      var gr = int.parse(gramController.text);
                      var pr = gr / gm;
                      var user = FirebaseAuth.instance.currentUser;
                      FirebaseFirestore.instance
                          .collection('consumed')
                          .doc()
                          .set({
                        'email': user!.email.toString(),
                        'time': DateTime.now(),
                        'name': selectedCategory,
                        'Carbs': ((data['Carbs'] * pr)).toInt(),
                        'Fat': ((data['Fat'] * pr)).toInt(),
                        'Fiber': ((data['Fiber'] * pr)).toInt(),
                        'Protein': ((data['Protein'] * pr)).toInt(),
                      });
                      setState(() {});
                      gramController.text = "";
                      
                      //var elg=(/gm)*gr;
                    },
                    height: 50,
                    // margin: EdgeInsets.symmetric(horizontal: 50),
                    color: const Color(0xffDFCCFB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    // decoration: BoxDecoration(
                    // ),
                    child: const Center(
                      child: Text(
                        "Upload food",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
