import 'package:dotdo/widgets/dumb_widgets/card/card_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/public_icon/public_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'inactive_challange_card_view_model.dart';

class InactiveChallangeCardWidget extends StatelessWidget {
  final bool public;
  final IconData iconData;
  final Color iconColor;
  final String lable;
  final Function onTap;

  const InactiveChallangeCardWidget(
      {Key key,
      this.public = false,
      @required this.iconData,
      @required this.iconColor,
      @required this.lable,
      @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InactiveChallangeCardViewModel>.reactive(
      builder: (BuildContext context, InactiveChallangeCardViewModel viewModel,
          Widget _) {
        return CardWidget(
          borderRadius: 20,
          height: 100,
          width: 150,
          onTap: onTap,
          padding: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // * Public Icon
                  PublicIconWidget(public: public),
                  // * Challange Icon
                  Icon(
                    iconData,
                    size: 24,
                    color: iconColor,
                  ),
                ],
              ),
              // * Lable
              LableTextWidget(
                lable: lable,
                maxLines: 2,
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => InactiveChallangeCardViewModel(),
    );
  }
}
