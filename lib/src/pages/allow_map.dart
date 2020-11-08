import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../controllers/distance_controller.dart';
import '../controllers/home_controller.dart';
import '../elements/DeliveryAddressBottomSheetWidget.dart';
import '../repository/user_repository.dart';
import '../repository/settings_repository.dart' as settingsRepo;

class AllowMap extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  AllowMap({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _AllowMapState createState() => _AllowMapState();
}

class _AllowMapState extends State<AllowMap> {
  HomeController _con = HomeController();
  bool loading = false;
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 230),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/img/logo.png',
                width: 200.0,
                height: 200.0,
              ), //   <--- image
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  isError
                      ? "You must accept the GPS to continue :("
                      : "Check Your location",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: width / 15,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: loading
                    ? Center(child: CircularProgressIndicator())
                    : InkWell(
                        onTap: () async {
                          setState(() {
                            loading = true;
                            isError = false;
                          });
                          try {
                            await DistanceController().calculate();
                            await data();
                            setState(() {
                              loading = false;
                            });
                            if (_con.topRestaurants.length == 0)
                              Navigator.of(context)
                                  .pushReplacementNamed('/sorry');
                            else
                              Navigator.of(context)
                                  .pushReplacementNamed('/Pages', arguments: 2);
                          } catch (err) {
                            setState(() {
                              loading = false;
                              isError = true;
                            });
                            DistanceController().calculate();
                          }
                          finally{
                            setState(() {
                              loading = false;
                              isError = true;
                            });
                          }
                        },
                        child: Container(
                          width: width / 3,
                          height: width / 10,
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: settingsRepo
                                        .deliveryAddress.value?.address ==
                                    null
                                ? Theme.of(context).focusColor.withOpacity(0.1)
                                : Theme.of(context).accentColor,
                          ),
                          child: Center(
                            child: Text(
                              S.of(context).delivery,
                              style: TextStyle(
                                  color: settingsRepo
                                              .deliveryAddress.value?.address ==
                                          null
                                      ? Theme.of(context).hintColor
                                      : Theme.of(context).primaryColor,
                                  fontSize: width / 20),
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future data() async {
    await _con.listenForSlides();
    await _con.listenForTopRestaurants();
    await _con.listenForTrendingFoods();
    await _con.listenForCategories();
    await _con.listenForPopularRestaurants();
    await _con.listenForRecentReviews();
  }
}
