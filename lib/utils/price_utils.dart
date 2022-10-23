class PriceUtils {
  static String formatPrice(int price) {
    return ((price / 1000 % 1) > 0) ? (price / 1000).toStringAsFixed(2) : (price / 1000).toStringAsFixed(0);
  }
}