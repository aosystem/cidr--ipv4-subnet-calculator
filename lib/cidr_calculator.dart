class CidrCalculationResult {
  CidrCalculationResult({
    required this.sanitizedIp,
    required this.ipParts,
    required this.networkParts,
    required this.broadcastParts,
    required this.maskParts,
    required this.prefix,
    required this.hostCount,
    required this.networkInt,
    required this.broadcastInt,
  });

  final String sanitizedIp;
  final List<int> ipParts;
  final List<int> networkParts;
  final List<int> broadcastParts;
  final List<int> maskParts;
  final int prefix;
  final int hostCount;
  final int networkInt;
  final int broadcastInt;
}

class CidrCalculator {
  static CidrCalculationResult calculate(String rawIp, int prefix) {
    final int normalizedPrefix = prefix.clamp(1, 32).toInt();
    final List<int> ipParts = _sanitizeIp(rawIp);
    final List<int> maskParts = maskFromPrefix(normalizedPrefix);
    final int ipInt = _ipToInt(ipParts);
    final int maskInt = _ipToInt(maskParts);
    final int wildcardInt = 0xFFFFFFFF ^ maskInt;
    final int networkInt = ipInt & maskInt;
    final int broadcastInt = networkInt | wildcardInt;
    final List<int> networkParts = _intToIp(networkInt);
    final List<int> broadcastParts = _intToIp(broadcastInt);
    final int hostCount = hostCountForPrefix(normalizedPrefix);
    return CidrCalculationResult(
      sanitizedIp: formatIp(ipParts),
      ipParts: ipParts,
      networkParts: networkParts,
      broadcastParts: broadcastParts,
      maskParts: maskParts,
      prefix: normalizedPrefix,
      hostCount: hostCount,
      networkInt: networkInt,
      broadcastInt: broadcastInt,
    );
  }

  static List<int> maskFromPrefix(int prefix) {
    final int normalized = prefix.clamp(0, 32).toInt();
    final List<int> mask = List<int>.filled(4, 0);
    for (int i = 0; i < 4; i++) {
      final int bits = normalized - (i * 8);
      if (bits >= 8) {
        mask[i] = 255;
      } else if (bits <= 0) {
        mask[i] = 0;
      } else {
        mask[i] = (0xFF << (8 - bits)) & 0xFF;
      }
    }
    return mask;
  }

  static int hostCountForPrefix(int prefix) {
    final int normalized = prefix.clamp(1, 32).toInt();
    return 1 << (32 - normalized);
  }

  static String formatIp(List<int> parts) => parts.join('.');

  static String formatBits(List<int> parts) => parts.map((int p) => p.toRadixString(2).padLeft(8, '0')).join('.');

  static List<int> intToIp(int value) => _intToIp(value);

  static List<int> _sanitizeIp(String rawIp) {
    final List<String> segments = (rawIp.trim().isEmpty ? '' : rawIp.trim()).split('.');
    segments.addAll(List<String>.filled(4, '0'));
    final List<int> result = List<int>.filled(4, 0);
    for (int i = 0; i < 4; i++) {
      final String segment = i < segments.length ? segments[i] : '0';
      final String digitsOnly = segment.replaceAll(RegExp(r'[^0-9]'), '');
      final String trimmed = digitsOnly.length <= 3 ? digitsOnly : digitsOnly.substring(digitsOnly.length - 3);
      int value = int.tryParse(trimmed) ?? 0;
      if (value < 0) {
        value = 0;
      } else if (value > 255) {
        value = 255;
      }
      result[i] = value;
    }
    return result;
  }

  static int _ipToInt(List<int> parts) {
    return (parts[0] << 24) | (parts[1] << 16) | (parts[2] << 8) | parts[3];
  }

  static List<int> _intToIp(int value) {
    final int normalized = value & 0xFFFFFFFF;
    return <int>[
      (normalized >> 24) & 0xFF,
      (normalized >> 16) & 0xFF,
      (normalized >> 8) & 0xFF,
      normalized & 0xFF,
    ];
  }
}
