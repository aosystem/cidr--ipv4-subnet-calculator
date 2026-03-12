import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cidr/ad_banner_widget.dart';
import 'package:cidr/ad_manager.dart';
import 'package:cidr/cidr_calculator.dart';
import 'package:cidr/l10n/app_localizations.dart';
import 'package:cidr/setting_page.dart';
import 'package:cidr/loading_screen.dart';
import 'package:cidr/main.dart';
import 'package:cidr/model.dart';
import 'package:cidr/parse_locale_tag.dart';
import 'package:cidr/theme_color.dart';
import 'package:cidr/theme_mode_number.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> with SingleTickerProviderStateMixin {
  late AdManager _adManager;
  late final TextEditingController _ipController;
  late int _selectedPrefix;
  late CidrCalculationResult _result;
  //
  late ThemeColor _themeColor;
  bool _isReady = false;
  bool _isFirst = true;
  //
  final TransformationController _transformationController = TransformationController();
  late AnimationController _animationController;
  Animation<Matrix4>? _zoomAnimation;
  final double _maxScale = 2.5;

  @override
  void initState() {
    super.initState();
    _initState();
  }

  void _initState() async {
    _adManager = AdManager();
    _ipController = TextEditingController();
    _ipController.addListener(_recalculate);
    _selectedPrefix = 32;
    _result = CidrCalculator.calculate('', _selectedPrefix);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
      _transformationController.value = _zoomAnimation!.value;
    });
    if (mounted) {
      setState(() {
        _isReady = true;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _ipController.removeListener(_recalculate);
    _ipController.dispose();
    _adManager.dispose();
    super.dispose();
  }

  void _handleDoubleTap(TapDownDetails details) {
    if (_animationController.isAnimating) {
      return;
    }
    final double currentScale = _transformationController.value.getMaxScaleOnAxis();
    final Matrix4 targetMatrix;
    if (currentScale > 1.1) {
      targetMatrix = Matrix4.identity();
    } else {
      final x = details.localPosition.dx;
      final y = details.localPosition.dy;
      targetMatrix = Matrix4.identity()
        ..translateByDouble(x, y, 1.0, 1.0)
        ..scaleByDouble(_maxScale, _maxScale, 1.0, 1.0)
        ..translateByDouble(-x, -y, 1.0, 1.0);
    }
    _zoomAnimation = Matrix4Tween(
      begin: _transformationController.value,
      end: targetMatrix,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _animationController.forward(from: 0);
  }

  void _recalculate() {
    if (!mounted) {
      return;
    }
    setState(() {
      _result = CidrCalculator.calculate(_ipController.text, _selectedPrefix);
    });
  }

  void _onPrefixChanged(int? prefix) {
    if (prefix == null || prefix == _selectedPrefix) {
      return;
    }
    setState(() {
      _selectedPrefix = prefix;
      _result = CidrCalculator.calculate(_ipController.text, _selectedPrefix);
    });
  }

  void _openSetting() async {
    final updated = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const SettingPage()),
    );
    if (!mounted) {
      return;
    }
    if (updated == true) {
      final mainState = context.findAncestorStateOfType<MainAppState>();
      if (mainState != null) {
        mainState
          ..locale = parseLocaleTag(Model.languageCode)
          ..themeMode = ThemeModeNumber.numberToThemeMode(Model.themeNumber)
          ..setState(() {});
      }
      if (mounted) {
        setState(() {
          _isFirst = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
      return Scaffold(
        body: LoadingScreen(),
      );
    }
    if (_isFirst) {
      _isFirst = false;
      _themeColor = ThemeColor(themeNumber: Model.themeNumber, context: context);
    }
    final AppLocalizations l = AppLocalizations.of(context)!;
    final TextTheme t = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: _themeColor.mainBack1,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: Text(l.appTitle,
          style: TextStyle(color: _themeColor.mainHeaderForeColor, fontSize: 15.0),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings,color: _themeColor.mainHeaderForeColor),
            onPressed: _openSetting,
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          onDoubleTapDown: _handleDoubleTap,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                color: _themeColor.mainBack1,
                child:SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    minScale: 1,
                    maxScale: _maxScale,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: _buildContent(l, t),
                    )
                  )
                )
              );
            }
          )
        )
      ),
      bottomNavigationBar: AdBannerWidget(adManager: _adManager),
    );
  }

  Widget _buildContent(AppLocalizations l, TextTheme t) {
    final String ipDisplay = _result.sanitizedIp;
    final String networkDisplay = CidrCalculator.formatIp(_result.networkParts);
    final String broadcastDisplay = CidrCalculator.formatIp(_result.broadcastParts);
    final String maskDisplay = CidrCalculator.formatIp(_result.maskParts);
    final String cidrDisplay = '$networkDisplay/${_result.prefix}';
    final String rangeDisplay = '$networkDisplay - $broadcastDisplay';
    final String hostRangeDisplay = _formatHostRange(l, _result);
    final String ipBitsDisplay = CidrCalculator.formatBits(_result.ipParts);
    final String maskBitsDisplay = CidrCalculator.formatBits(_result.maskParts);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          color: _themeColor.mainBack2,
          child: _buildInputIp(l, t),
        ),
        Container(
          color: _themeColor.mainBack3,
          child: _buildInputMask(l, t),
        ),
        Container(
          color: _themeColor.mainBack4,
          child: _buildResult(l.labelIp, ipDisplay, t),
        ),
        Container(
          color: _themeColor.mainBack5,
          child: _buildResult(l.labelRange, rangeDisplay, t),
        ),
        Container(
          color: _themeColor.mainBack6,
          child: _buildResult(l.labelNetwork, networkDisplay, t),
        ),
        Container(
          color: _themeColor.mainBack7,
          child: _buildResult(l.labelHostRange, hostRangeDisplay, t),
        ),
        Container(
          color: _themeColor.mainBack8,
          child: _buildResult(l.labelBroadcast, broadcastDisplay, t),
        ),
        Container(
          color: _themeColor.mainBack9,
          child: _buildResult(l.labelCidr, cidrDisplay, t),
        ),
        Container(
          color: _themeColor.mainBack10,
          child: _buildResult(l.labelMask, maskDisplay, t),
        ),
        Container(
          color: _themeColor.mainBack11,
          child: _buildBits(l.labelBits, ipBitsDisplay, maskBitsDisplay, t),
        ),
        const SizedBox(height:50),
      ]
    );
  }

  Widget _buildInputIp(AppLocalizations l, TextTheme t) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
            Row(
              children: [
                Text(l.inputIp,style: t.bodySmall),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _ipController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: GoogleFonts.robotoMono(fontWeight: FontWeight.w600),
                    inputFormatters: <TextInputFormatter>[
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        final replaced = newValue.text.replaceAll(',', '.');
                        return TextEditingValue(
                          text: replaced,
                          selection: TextSelection.collapsed(offset: replaced.length),
                        );
                      }),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    decoration: InputDecoration(
                      hintText: '0.0.0.0',
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ],
      )
    );
  }

  Widget _buildInputMask(AppLocalizations l, TextTheme t) {
    final locale = Model.languageCode.isEmpty ? null : Model.languageCode;
    final NumberFormat numberFormat = NumberFormat.decimalPattern(locale);
    final List<DropdownMenuItem<int>> items = List<DropdownMenuItem<int>>.generate(32, (int index) {
      final int prefix = 32 - index;
      final String optionLabel = _formatSubnetOption(prefix, numberFormat);
      return DropdownMenuItem<int>(
        value: prefix,
        child: Text(optionLabel,
          style: GoogleFonts.robotoMono(fontWeight: FontWeight.w600).copyWith(color: _themeColor.mainForeColor)
        ),
      );
    });
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
            Text(l.inputSubnet, style: t.bodySmall),
            InputDecorator(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: _selectedPrefix,
                  isExpanded: true,
                  items: items,
                  onChanged: _onPrefixChanged,
                  style: GoogleFonts.robotoMono(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ])
        ],
      )
    );
  }

  Widget _buildResult(String label, String value, TextTheme t) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: SelectableText(label,style: t.bodySmall),
          ),
          Expanded(
            flex: 7,
            child: SelectableText(value, style: GoogleFonts.robotoMono(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildBits(String label, String ipBits, String maskBits, TextTheme t) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SelectableText(
              label,
              style: t.bodySmall,
            ),
            const SizedBox(height: 2),
            SelectableText(
              ipBits,
              style: GoogleFonts.robotoMono(fontWeight: FontWeight.w600),
            ),
            SelectableText(
              maskBits,
              style: GoogleFonts.robotoMono(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  String _formatSubnetOption(int prefix, NumberFormat numberFormat) {
    final List<int> maskParts = CidrCalculator.maskFromPrefix(prefix);
    final String mask = CidrCalculator.formatIp(maskParts);
    final int hostCount = CidrCalculator.hostCountForPrefix(prefix);
    final String hostCountString = numberFormat.format(hostCount);
    return '$mask (/$prefix) [$hostCountString]';
  }

  String _formatHostRange(AppLocalizations l, CidrCalculationResult result) {
    final String network = CidrCalculator.formatIp(result.networkParts);
    final String broadcast = CidrCalculator.formatIp(result.broadcastParts);
    if (result.hostCount <= 1) {
      return '$network ${l.hostSingleSuffix}';
    }
    if (result.hostCount == 2) {
      return '$network - $broadcast ${l.hostTwoSuffix}';
    }
    final List<int> firstHost = CidrCalculator.intToIp(result.networkInt + 1);
    final List<int> lastHost = CidrCalculator.intToIp(result.broadcastInt - 1);
    return '${CidrCalculator.formatIp(firstHost)} - ${CidrCalculator.formatIp(lastHost)}';
  }

}
