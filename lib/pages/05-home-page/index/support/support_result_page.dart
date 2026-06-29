import 'package:flutter/material.dart';
import 'package:myapp/custom-shapes/support-page-shapes/support_shape1.dart';
import 'package:myapp/custom-shapes/support-page-shapes/support_shape2.dart';
import 'package:myapp/custom-shapes/support-page-shapes/support_shape3.dart';
import 'package:myapp/custom-shapes/support-page-shapes/support_shape4.dart';
import 'package:myapp/custom-shapes/support-page-shapes/support_shape5.dart';
import 'package:myapp/custom-widgets/display_no_data.dart';
import 'package:myapp/data-class/ticket.dart';

class SupportResultPage extends StatefulWidget {
  const SupportResultPage({super.key, this.supportTicket});

  final Ticket? supportTicket;

  @override
  State<SupportResultPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SupportResultPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Size?> _sizeAnimation;
  late Animation<double> _curvedAnimation;
  late Animation<double> _opacityAnimation;

  void _initAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
  }

  @override
  void initState() {
    super.initState();
    _initAnimationController();

    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );

    _opacityAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    );

    _sizeAnimation = SizeTween(
      begin: const Size(0.0, 0.0),
      end: const Size(154, 154),
    ).animate(_curvedAnimation);

    //execute the animation
    _animationController.forward();

    _animationController.addListener(() {
      debugPrint('The animation value is : $_animationController.value');
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.supportTicket;

    if (data == null) {
      return DisplayNoData();
    }

    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 20,
        children: [
          //used expanded to trigger Positioned - hit box
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // center point of the shape
                // Container(color: Colors.blue),
                _buildShape2(),
                _buildShape1(),
                _buildShape3(),
                _buildShape4(),
                _buildShape5(),

                _buildCloseButton(theme),

                Center(
                  child: Column(
                    spacing: 30,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Report submitted successfully',
                        style: theme.textTheme.headlineSmall,
                      ),
                      SizedBox(
                        width: 300,
                        child: Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            style: theme.textTheme.bodyLarge,
                            children: [
                              TextSpan(text: 'A new Ticket'),
                              TextSpan(text: ' '),
                              TextSpan(
                                text: '#${data.ticketNumber}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: ' '),
                              TextSpan(text: 'is now active '),
                              TextSpan(text: ' '),
                              TextSpan(
                                text:
                                    'You can view your ticket status on the Account page.',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCloseButton(ThemeData theme) {
    return Positioned(
      top: 112.5,
      right: 23,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              // color: Colors.teal,
              shape: BoxShape.circle,
            ),
            child: Column(
              children: [
                Icon(Icons.close),
                Text('Close', style: theme.textTheme.labelLarge),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShape5() {
    return Positioned(
      top: 60,
      right: -20,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            width: 170,
            height: 170,
            alignment: Alignment.centerRight,
            child: CustomPaint(
              painter: SupportShape5(),
              size: _sizeAnimation.value!,
            ),
          );
        },
      ),
    );
  }

  Widget _buildShape4() {
    return Positioned(
      top: 180,
      left: -60,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            // color: Colors.green,
            width: 170,
            height: 170,
            alignment: Alignment.centerLeft,
            child: CustomPaint(
              painter: SupportShape4(),
              size: _sizeAnimation.value!,
            ),
          );
        },
      ),
    );
  }

  Widget _buildShape3() {
    return Positioned(
      bottom: 0,
      left: 30,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            // color: Colors.green,
            width: 170,
            height: 170,
            alignment: Alignment.bottomCenter,
            child: CustomPaint(
              painter: SupportShape3(),
              size: _sizeAnimation.value!,
            ),
          );
        },
      ),
    );
  }

  Widget _buildShape2() {
    return Positioned(
      bottom: 120,
      right: -30,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            // color: Colors.green,
            width: 170,
            height: 170,
            alignment: Alignment.centerRight,
            child: CustomPaint(
              painter: SupportShape2(),
              size: _sizeAnimation.value!,
            ),
          );
        },
      ),
    );
  }

  Widget _buildShape1() {
    return Positioned(
      bottom: 130,
      right: -60,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            // color: Colors.green,
            width: 170,
            height: 170,
            alignment: Alignment.centerRight,
            child: CustomPaint(
              painter: SupportShape1(),
              size: _sizeAnimation.value!,
            ),
          );
        },
      ),
    );
  }
}
