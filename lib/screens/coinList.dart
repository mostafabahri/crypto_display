import 'package:flutter/material.dart';
import 'package:crypto_display/coin.dart';
import 'package:crypto_display/screens/coinDetail.dart';
import 'package:flutter/foundation.dart';

class CoinList extends StatelessWidget {
  final List coinJsonData;

  CoinList({@required this.coinJsonData});


  @override
  Widget build(BuildContext context) {
    return new Center(
        child: coinJsonData.length > 0 ?
        new ListView(
          children: _listChildren(),
        )
            : new ListView()
    );
  }

  List<Widget> _listChildren() {
    List<Widget> children = new List<Widget>();
    for (int i = 0; i < 2 * coinJsonData.length - 1; i++) {
      children.add(_baseRowBuilder(i));
    }
    return children;
  }

  Widget _baseRowBuilder(int i) {
    if (i.isOdd)
      return new Divider();
    else
      return _coinRowBuilder(this.coinJsonData[i ~/ 2]);
  }


  Widget _coinRowBuilder(Map<String, dynamic> coinJson) {
    return new CoinListItem(
        new Coin.fromJson(coinJson)
    );
  }

}

class CoinListItem extends StatelessWidget {
  final Coin coin;

  CoinListItem(Coin coin)
      : coin = coin;

  void _onTap(BuildContext context) {
    Navigator.of(context).push(
        new MaterialPageRoute(builder: (context) {
          return new Scaffold(
            appBar: new AppBar(
                title: new Text("Coin Stats")
            ),
            body: new CoinItemDetail(this.coin),
          );
        })
    );
  }

  Icon _downRedIcon() =>
      new Icon(
        Icons.arrow_drop_down,
        color: Colors.red,
      );


  Icon _upGreenIcon() =>
      new Icon(
        Icons.arrow_drop_up,
        color: Colors.green,
      );

  @override
  Widget build(BuildContext context) {
    return
      new ListTile(
        leading: new Icon(Icons.local_atm),
        title: new Text(coin.name),
        trailing: coin.change1Hour >= 0
            ? _upGreenIcon()
            : _downRedIcon(),
        subtitle: new Text("\$${coin.priceUsd}"),
        onTap: () => _onTap(context),
      );
  }
}
