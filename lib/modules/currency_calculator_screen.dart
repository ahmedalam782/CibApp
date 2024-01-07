import 'package:cib/modules/cubit/cubit.dart';
import 'package:cib/modules/cubit/state.dart';
import 'package:cib/shared/components/currency_components.dart';
import 'package:cib/shared/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CurrencyCalculator extends StatelessWidget {
  static const String routeName = 'CurrencyCalculator';
  final formatCurrency = NumberFormat('#,##0.00');
  final currencyOfUSA = currencyValue / 30.8;
  final currencyOfEGY = currencyValue * 30.8;
  final min = 0.0;
  final max = 999999990.00;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CibCubit, CibState>(
      builder: (context, state) {
        CibCubit cubit = CibCubit.get(context);
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/mobile cover.jpg',
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  currencyValue = 0;
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              title: Center(
                child: Text(
                  'Currency Calculator',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CurrencyComponent(
                      title: 'Convert from',
                      image: isPressedChangeCurrency
                          ? 'https://cdn.britannica.com/33/4833-004-828A9A84/Flag-United-States-of-America.jpg'
                          : 'https://flagmakers.co.uk/media/fbjgwi2f/flag_of_egypt.png?anchor=center&mode=crop&width=800&height=0&format=webp&quality=50&rnd=132442099247130000.jpg',
                      nameOfCurrency: isPressedChangeCurrency ? 'USD' : 'EGP',
                    ),
                    IconButton(
                      onPressed: () => isPressedChangeCurrency =
                          cubit.changeShowPassword(isPressedChangeCurrency),
                      icon: Icon(
                        Icons.cached,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    CurrencyComponent(
                      title: 'To',
                      image: isPressedChangeCurrency
                          ? 'https://flagmakers.co.uk/media/fbjgwi2f/flag_of_egypt.png?anchor=center&mode=crop&width=800&height=0&format=webp&quality=50&rnd=132442099247130000.jpg'
                          : 'https://cdn.britannica.com/33/4833-004-828A9A84/Flag-United-States-of-America.jpg',
                      nameOfCurrency: isPressedChangeCurrency ? 'EGP' : 'USD',
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () => cubit.changePressedIcon(min),
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: Text(
                            isPressedChangeCurrency
                                ? 'USD ${formatCurrency.format(currencyValue)}'
                                : 'EGP ${formatCurrency.format(currencyValue)}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SliderTheme(
                          data: SliderThemeData(
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 10.0),
                          ),
                          child: Container(
                            width: 250,
                            child: Slider(
                                activeColor: Colors.white,
                                inactiveColor: Colors.grey,
                                thumbColor: Color(0xff002E71),
                                max: max,
                                min: min,
                                value: currencyValue,
                                onChanged: (value) {
                                  cubit.changeCurrencyValue(value);
                                }),
                          ),
                        ),
                        Center(
                          child: Text(
                            isPressedChangeCurrency
                                ? 'EGP ${formatCurrency.format(currencyOfEGY)}'
                                : 'USD ${formatCurrency.format(currencyOfUSA)}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () => cubit.changePressedIcon(max),
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
