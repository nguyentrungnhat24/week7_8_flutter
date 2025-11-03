import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/custom_bottom_bar.dart';
import 'package:fl_week01/data/data.dart';
import 'package:fl_week01/src/blocs/homepage_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  //Thêm initState để gửi sự kiện
  @override
  void initState() {
    super.initState();
    // Gửi sự kiện FetchDataEvent để yêu cầu BLoC bắt đầu lấy dữ liệu
    context.read<HomepageBloc>().add(FetchDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: BlocBuilder<HomepageBloc, HomepageState>(
        builder: (context, state) {
          if (state is HomepageLoading || state is HomepageInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomepageLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// logo
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        width: myWidth * 0.2,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: Image.asset(
                          "assets/images/Group.png",
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                  ),

                  /// location
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.location_on, color: Colors.grey),
                          SizedBox(width: 4),
                          Text(
                            "Dhaka, Banassre",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// search bar
                  Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search store",
                        filled: true,
                        fillColor: const Color.fromARGB(255, 233, 232, 235),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  /// banner
                  Padding(
                    padding: EdgeInsets.only(bottom: myHeight * 0.01),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.only(bottom: myHeight * 0.012),
                        width: myWidth * 0.92,
                        color: Colors.white,
                        child: Image.asset(
                          "assets/images/BannerVegetables.png",
                          width: myWidth * 0.92,
                          height: myHeight * 0.18,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  /// sections
                  SizedBox(
                    height: myHeight * 0.6, // giới hạn chiều cao
                    child: ListView.builder(
                      itemCount: sections.length,
                      itemBuilder: (context, index) {
                        final section = sections[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// title + see all
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    section['title'].toString(),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "See all",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              /// nếu là Best Selling thì hiển thị categories
                              if (section['title'] == "Best Selling")
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: myHeight * 0.012,
                                  ),
                                  child: SizedBox(
                                    height: myHeight * 0.13,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(width: myWidth * 0.03),
                                      itemCount: categories.length,
                                      itemBuilder: (context, index) {
                                        final category = categories[index];
                                        final List<Color> bgColors = [
                                          Color(0xFFFDEEEB),
                                          Color(0xFFEAF6F0),
                                          Color(0xFFFDF6E3),
                                          Color(0xFFF3F1FA),
                                          Color(0xFFFDEEEB),
                                          Color(0xFFEAF6F0),
                                          Color(0xFFFDF6E3),
                                        ];
                                        final Color bgColor =
                                            bgColors[index % bgColors.length];
                                        return Container(
                                          width: myWidth * 0.42,
                                          decoration: BoxDecoration(
                                            color: bgColor,
                                            borderRadius: BorderRadius.circular(
                                              myWidth * 0.04,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: myWidth * 0.04,
                                              vertical: myHeight * 0.018,
                                            ),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  category['image']!,
                                                  width: myWidth * 0.09,
                                                  height: myWidth * 0.09,
                                                  fit: BoxFit.contain,
                                                ),
                                                SizedBox(width: myWidth * 0.04),
                                                Expanded(
                                                  child: Text(
                                                    category['name']!,
                                                    style: TextStyle(
                                                      fontSize: myWidth * 0.045,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),

                              /// product list ngang
                              SizedBox(
                                height: myHeight * 0.32,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 12),
                                  itemCount:
                                      (section['products']
                                              as List<Map<String, dynamic>>)
                                          .length,
                                  itemBuilder: (context, i) {
                                    final products =
                                        section['products']
                                            as List<Map<String, dynamic>>;
                                    final product = products[i];
                                    return Container(
                                      width: myWidth * 0.4,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Image.asset(
                                                product["image"] ??
                                                    "assets/images/default.png",
                                                height: myHeight * 0.1,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              product["name"],
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              product["desc"],
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[600],
                                              ),
                                            ),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  product["price"],
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                  ),
                                                  child: IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                    ),
                                                    iconSize: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is HomepageError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text("Unknown state"));
          }
        },
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
