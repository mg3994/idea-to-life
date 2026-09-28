import 'package:firebase_analytics/firebase_analytics.dart'
    show
        AnalyticsCallOptions,
        AnalyticsEventItem,
        FirebaseAnalyticsObserver,
        ScreenNameExtractor,
        defaultNameExtractor,
        defaultRouteFilter,
        FirebaseAnalytics;
import 'package:firebase_analytics/observer.dart' show RouteFilter;
import 'package:flutter/services.dart' show PlatformException;

abstract interface class AnalyticsGateway {
  const AnalyticsGateway();

  FirebaseAnalyticsObserver observer({
    ScreenNameExtractor nameExtractor = defaultNameExtractor,
    RouteFilter routeFilter = defaultRouteFilter,
    void Function(PlatformException error)? onError,
  });

  Future<bool> isSupported();

  Future<String?> get appInstanceId;

  Future<int?> getSessionId();

  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
    List<AnalyticsEventItem>? items,
    AnalyticsCallOptions? callOptions,
  });

  Future<void> setConsent({
    bool? adStorageConsentGranted,
    bool? analyticsStorageConsentGranted,
    bool? adPersonalizationSignalsConsentGranted,
    bool? adUserDataConsentGranted,
    bool? functionalityStorageConsentGranted,
    bool? personalizationStorageConsentGranted,
    bool? securityStorageConsentGranted,
  });

  Future<void> setDefaultEventParameters(
    Map<String, Object?>? defaultParameters,
  );

  Future<void> setAnalyticsCollectionEnabled(bool enabled);

  Future<void> setUserId({
    String? id,
    AnalyticsCallOptions? callOptions,
  });

  Future<void> setUserProperty({
    required String name,
    required String? value,
    AnalyticsCallOptions? callOptions,
  });

  Future<void> resetAnalyticsData();

  Future<void> logAddPaymentInfo({
    String? coupon,
    String? currency,
    String? paymentType,
    double? value,
    List<AnalyticsEventItem>? items,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  });

  Future<void> logAddShippingInfo({
    String? coupon,
    String? currency,
    double? value,
    String? shippingTier,
    List<AnalyticsEventItem>? items,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  });

  Future<void> logAddToCart({
    List<AnalyticsEventItem>? items,
    double? value,
    String? currency,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  });

  Future<void> logAddToWishlist({
    List<AnalyticsEventItem>? items,
    double? value,
    String? currency,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  });

  Future<void> logAdImpression({
    String? adPlatform,
    String? adSource,
    String? adFormat,
    String? adUnitName,
    double? value,
    String? currency,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  });

  Future<void> logAppOpen({
    AnalyticsCallOptions? callOptions,
    Map<String, Object>? parameters,
  });

  Future<void> logBeginCheckout({
    double? value,
    String? currency,
    List<AnalyticsEventItem>? items,
    String? coupon,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  });

  Future<void> logCampaignDetails({
    required String source,
    required String medium,
    required String campaign,
    String? term,
    String? content,
    String? aclid,
    String? cp1,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  });

  Future<void> logEarnVirtualCurrency({
    required String virtualCurrencyName,
    required num value,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  });

  Future<void> logGenerateLead({
    String? currency,
    double? value,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  });

  Future<void> logJoinGroup({
    required String groupId,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  });

  Future<void> logLevelUp({
    required int level,
    String? character,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  });

  Future<void> logLevelStart({
    required String levelName,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  });

  Future<void> logLevelEnd({
    required String levelName,
    int? success,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  });

  Future<void> logLogin({
    String? loginMethod,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  });

  Future<void> logPostScore({
    required int score,
    int? level,
    String? character,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  });

  Future<void> logPurchase({
    String? currency,
    String? coupon,
    double? value,
    List<AnalyticsEventItem>? items,
    double? tax,
    double? shipping,
    String? transactionId,
    String? affiliation,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  });

  Future<void> logRemoveFromCart({
    String? currency,
    double? value,
    List<AnalyticsEventItem>? items,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  });

  Future<void> logScreenView({
    String? screenClass,
    String? screenName,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  });

  Future<void> logSelectItem({
    String? itemListId,
    String? itemListName,
    List<AnalyticsEventItem>? items,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  });

  Future<void> logSelectPromotion({
    String? creativeName,
    String? creativeSlot,
    List<AnalyticsEventItem>? items,
    String? locationId,
    String? promotionId,
    String? promotionName,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  });

  Future<void> logViewCart({
    String? currency,
    double? value,
    List<AnalyticsEventItem>? items,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  });

  Future<void> logSearch({
    required String searchTerm,
    int? numberOfNights,
    int? numberOfRooms,
    int? numberOfPassengers,
    String? origin,
    String? destination,
    String? startDate,
    String? endDate,
    String? travelClass,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  });

  Future<void> logSelectContent({
    required String contentType,
    required String itemId,
    Map<String, Object>? parameters,
  });

  Future<void> logShare({
    required String contentType,
    required String itemId,
    required String method,
    Map<String, Object>? parameters,
  });

  Future<void> logSignUp({
    required String signUpMethod,
    Map<String, Object>? parameters,
  });

  Future<void> logSpendVirtualCurrency({
    required String itemName,
    required String virtualCurrencyName,
    required num value,
    Map<String, Object>? parameters,
  });

  Future<void> logTutorialBegin({
    Map<String, Object>? parameters,
  });

  Future<void> logTutorialComplete({
    Map<String, Object>? parameters,
  });

  Future<void> logUnlockAchievement({
    required String id,
    Map<String, Object>? parameters,
  });

  Future<void> logViewItem({
    String? currency,
    double? value,
    List<AnalyticsEventItem>? items,
    Map<String, Object>? parameters,
  });

  Future<void> logViewItemList({
    List<AnalyticsEventItem>? items,
    String? itemListId,
    String? itemListName,
    Map<String, Object>? parameters,
  });

  Future<void> logViewPromotion({
    String? creativeName,
    String? creativeSlot,
    List<AnalyticsEventItem>? items,
    String? locationId,
    String? promotionId,
    String? promotionName,
    Map<String, Object>? parameters,
  });

  Future<void> logViewSearchResults({
    required String searchTerm,
    Map<String, Object>? parameters,
  });

  Future<void> logRefund({
    String? currency,
    String? coupon,
    double? value,
    double? tax,
    double? shipping,
    String? transactionId,
    String? affiliation,
    List<AnalyticsEventItem>? items,
    Map<String, Object>? parameters,
  });

  Future<void> logInAppPurchase({
    String? currency,
    bool? freeTrial,
    double? price,
    bool? priceIsDiscounted,
    String? productID,
    String? productName,
    int? quantity,
    bool? subscription,
    num? value,
  });

  Future<void> logTransaction(String transactionId);

  Future<void> setSessionTimeoutDuration(Duration timeout);

  Future<void> initiateOnDeviceConversionMeasurementWithEmailAddress(
    String emailAddress,
  );

  Future<void> initiateOnDeviceConversionMeasurementWithPhoneNumber(
    String phoneNumber,
  );

  Future<void> initiateOnDeviceConversionMeasurementWithHashedEmailAddress(
    String hashedEmailAddress,
  );

  Future<void> initiateOnDeviceConversionMeasurementWithHashedPhoneNumber(
    String hashedPhoneNumber,
  );
}

final class const FirebaseAnalyticsGateway({
  final FirebaseAnalytics? _analytics,
}) implements AnalyticsGateway {
  FirebaseAnalytics get _instance => _analytics ?? FirebaseAnalytics.instance;

  Future<bool> _supported() async {
    return _instance.isSupported();
  }

  @override
  FirebaseAnalyticsObserver observer({
    ScreenNameExtractor nameExtractor = defaultNameExtractor,
    RouteFilter routeFilter = defaultRouteFilter,
    void Function(PlatformException error)? onError,
  }) {
    return FirebaseAnalyticsObserver(
      analytics: _instance,
      nameExtractor: nameExtractor,
      routeFilter: routeFilter,
      onError: onError,
    );
  }

  @override
  Future<bool> isSupported() async {
    return _instance.isSupported();
  }

  @override
  Future<String?> get appInstanceId async {
    if (!await _supported()) return null;
    return _instance.appInstanceId;
  }

  @override
  Future<int?> getSessionId() async {
    if (!await _supported()) return null;
    return _instance.getSessionId();
  }

  @override
  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
    List<AnalyticsEventItem>? items,
    AnalyticsCallOptions? callOptions,
  }) async {
    if (!await _supported()) return;

    await _instance.logEvent(
      name: name,
      parameters: parameters,
      items: items,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> setConsent({
    bool? adStorageConsentGranted,
    bool? analyticsStorageConsentGranted,
    bool? adPersonalizationSignalsConsentGranted,
    bool? adUserDataConsentGranted,
    bool? functionalityStorageConsentGranted,
    bool? personalizationStorageConsentGranted,
    bool? securityStorageConsentGranted,
  }) async {
    if (!await _supported()) return;

    await _instance.setConsent(
      adStorageConsentGranted: adStorageConsentGranted,
      analyticsStorageConsentGranted: analyticsStorageConsentGranted,
      adPersonalizationSignalsConsentGranted:
          adPersonalizationSignalsConsentGranted,
      adUserDataConsentGranted: adUserDataConsentGranted,
      functionalityStorageConsentGranted: functionalityStorageConsentGranted,
      personalizationStorageConsentGranted:
          personalizationStorageConsentGranted,
      securityStorageConsentGranted: securityStorageConsentGranted,
    );
  }

  @override
  Future<void> setDefaultEventParameters(
    Map<String, Object?>? defaultParameters,
  ) async {
    if (!await _supported()) return;

    await _instance.setDefaultEventParameters(defaultParameters);
  }

  @override
  Future<void> setAnalyticsCollectionEnabled(bool enabled) async {
    if (!await _supported()) return;

    await _instance.setAnalyticsCollectionEnabled(enabled);
  }

  @override
  Future<void> setUserId({
    String? id,
    AnalyticsCallOptions? callOptions,
  }) async {
    if (!await _supported()) return;

    await _instance.setUserId(id: id, callOptions: callOptions);
  }

  @override
  Future<void> setUserProperty({
    required String name,
    required String? value,
    AnalyticsCallOptions? callOptions,
  }) async {
    if (!await _supported()) return;

    await _instance.setUserProperty(
      name: name,
      value: value,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> resetAnalyticsData() async {
    if (!await _supported()) return;

    await _instance.resetAnalyticsData();
  }

  @override
  Future<void> logAddPaymentInfo({
    String? coupon,
    String? currency,
    String? paymentType,
    double? value,
    List<AnalyticsEventItem>? items,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    if (!await _supported()) return;

    await _instance.logAddPaymentInfo(
      coupon: coupon,
      currency: currency,
      paymentType: paymentType,
      value: value,
      items: items,
      parameters: parameters,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> logAddShippingInfo({
    String? coupon,
    String? currency,
    double? value,
    String? shippingTier,
    List<AnalyticsEventItem>? items,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    if (!await _supported()) return;

    await _instance.logAddShippingInfo(
      coupon: coupon,
      currency: currency,
      value: value,
      shippingTier: shippingTier,
      items: items,
      parameters: parameters,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> logAddToCart({
    List<AnalyticsEventItem>? items,
    double? value,
    String? currency,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    if (!await _supported()) return;

    await _instance.logAddToCart(
      items: items,
      value: value,
      currency: currency,
      parameters: parameters,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> logAddToWishlist({
    List<AnalyticsEventItem>? items,
    double? value,
    String? currency,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    if (!await _supported()) return;

    await _instance.logAddToWishlist(
      items: items,
      value: value,
      currency: currency,
      parameters: parameters,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> logAdImpression({
    String? adPlatform,
    String? adSource,
    String? adFormat,
    String? adUnitName,
    double? value,
    String? currency,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    if (!await _supported()) return;

    await _instance.logAdImpression(
      adPlatform: adPlatform,
      adSource: adSource,
      adFormat: adFormat,
      adUnitName: adUnitName,
      value: value,
      currency: currency,
      parameters: parameters,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> logAppOpen({
    AnalyticsCallOptions? callOptions,
    Map<String, Object>? parameters,
  }) async {
    if (!await _supported()) return;

    await _instance.logAppOpen(
      callOptions: callOptions,
      parameters: parameters,
    );
  }

  @override
  Future<void> logBeginCheckout({
    double? value,
    String? currency,
    List<AnalyticsEventItem>? items,
    String? coupon,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    if (!await _supported()) return;

    await _instance.logBeginCheckout(
      value: value,
      currency: currency,
      items: items,
      coupon: coupon,
      parameters: parameters,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> logCampaignDetails({
    required String source,
    required String medium,
    required String campaign,
    String? term,
    String? content,
    String? aclid,
    String? cp1,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    if (!await _supported()) return;

    await _instance.logCampaignDetails(
      source: source,
      medium: medium,
      campaign: campaign,
      term: term,
      content: content,
      aclid: aclid,
      cp1: cp1,
      parameters: parameters,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> logEarnVirtualCurrency({
    required String virtualCurrencyName,
    required num value,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    if (!await _supported()) return;

    await _instance.logEarnVirtualCurrency(
      virtualCurrencyName: virtualCurrencyName,
      value: value,
      parameters: parameters,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> logGenerateLead({
    String? currency,
    double? value,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    if (!await _supported()) return;

    await _instance.logGenerateLead(
      currency: currency,
      value: value,
      parameters: parameters,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> logJoinGroup({
    required String groupId,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    if (!await _supported()) return;

    await _instance.logJoinGroup(
      groupId: groupId,
      parameters: parameters,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> logLevelUp({
    required int level,
    String? character,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    if (!await _supported()) return;

    await _instance.logLevelUp(
      level: level,
      character: character,
      parameters: parameters,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> logLevelStart({
    required String levelName,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    if (!await _supported()) return;

    await _instance.logLevelStart(
      levelName: levelName,
      parameters: parameters,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> logLevelEnd({
    required String levelName,
    int? success,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    if (!await _supported()) return;

    await _instance.logLevelEnd(
      levelName: levelName,
      success: success,
      parameters: parameters,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> logLogin({
    String? loginMethod,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    if (!await _supported()) return;

    await _instance.logLogin(
      loginMethod: loginMethod,
      parameters: parameters,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> logPostScore({
    required int score,
    int? level,
    String? character,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    if (!await _supported()) return;

    await _instance.logPostScore(
      score: score,
      level: level,
      character: character,
      parameters: parameters,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> logPurchase({
    String? currency,
    String? coupon,
    double? value,
    List<AnalyticsEventItem>? items,
    double? tax,
    double? shipping,
    String? transactionId,
    String? affiliation,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    if (!await _supported()) return;

    await _instance.logPurchase(
      currency: currency,
      coupon: coupon,
      value: value,
      items: items,
      tax: tax,
      shipping: shipping,
      transactionId: transactionId,
      affiliation: affiliation,
      parameters: parameters,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> logRemoveFromCart({
    String? currency,
    double? value,
    List<AnalyticsEventItem>? items,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    if (!await _supported()) return;

    await _instance.logRemoveFromCart(
      currency: currency,
      value: value,
      items: items,
      parameters: parameters,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> logScreenView({
    String? screenClass,
    String? screenName,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    if (!await _supported()) return;

    await _instance.logScreenView(
      screenClass: screenClass,
      screenName: screenName,
      parameters: parameters,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> logSelectItem({
    String? itemListId,
    String? itemListName,
    List<AnalyticsEventItem>? items,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    if (!await _supported()) return;

    await _instance.logSelectItem(
      itemListId: itemListId,
      itemListName: itemListName,
      items: items,
      parameters: parameters,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> logSelectPromotion({
    String? creativeName,
    String? creativeSlot,
    List<AnalyticsEventItem>? items,
    String? locationId,
    String? promotionId,
    String? promotionName,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    if (!await _supported()) return;

    await _instance.logSelectPromotion(
      creativeName: creativeName,
      creativeSlot: creativeSlot,
      items: items,
      locationId: locationId,
      promotionId: promotionId,
      promotionName: promotionName,
      parameters: parameters,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> logViewCart({
    String? currency,
    double? value,
    List<AnalyticsEventItem>? items,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    if (!await _supported()) return;

    await _instance.logViewCart(
      currency: currency,
      value: value,
      items: items,
      parameters: parameters,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> logSearch({
    required String searchTerm,
    int? numberOfNights,
    int? numberOfRooms,
    int? numberOfPassengers,
    String? origin,
    String? destination,
    String? startDate,
    String? endDate,
    String? travelClass,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    if (!await _supported()) return;

    await _instance.logSearch(
      searchTerm: searchTerm,
      numberOfNights: numberOfNights,
      numberOfRooms: numberOfRooms,
      numberOfPassengers: numberOfPassengers,
      origin: origin,
      destination: destination,
      startDate: startDate,
      endDate: endDate,
      travelClass: travelClass,
      parameters: parameters,
      callOptions: callOptions,
    );
  }

  @override
  Future<void> logSelectContent({
    required String contentType,
    required String itemId,
    Map<String, Object>? parameters,
  }) async {
    if (!await _supported()) return;

    await _instance.logSelectContent(
      contentType: contentType,
      itemId: itemId,
      parameters: parameters,
    );
  }

  @override
  Future<void> logShare({
    required String contentType,
    required String itemId,
    required String method,
    Map<String, Object>? parameters,
  }) async {
    if (!await _supported()) return;

    await _instance.logShare(
      contentType: contentType,
      itemId: itemId,
      method: method,
      parameters: parameters,
    );
  }

  @override
  Future<void> logSignUp({
    required String signUpMethod,
    Map<String, Object>? parameters,
  }) async {
    if (!await _supported()) return;

    await _instance.logSignUp(
      signUpMethod: signUpMethod,
      parameters: parameters,
    );
  }

  @override
  Future<void> logSpendVirtualCurrency({
    required String itemName,
    required String virtualCurrencyName,
    required num value,
    Map<String, Object>? parameters,
  }) async {
    if (!await _supported()) return;

    await _instance.logSpendVirtualCurrency(
      itemName: itemName,
      virtualCurrencyName: virtualCurrencyName,
      value: value,
      parameters: parameters,
    );
  }

  @override
  Future<void> logTutorialBegin({Map<String, Object>? parameters}) async {
    if (!await _supported()) return;

    await _instance.logTutorialBegin(parameters: parameters);
  }

  @override
  Future<void> logTutorialComplete({Map<String, Object>? parameters}) async {
    if (!await _supported()) return;

    await _instance.logTutorialComplete(parameters: parameters);
  }

  @override
  Future<void> logUnlockAchievement({
    required String id,
    Map<String, Object>? parameters,
  }) async {
    if (!await _supported()) return;

    await _instance.logUnlockAchievement(id: id, parameters: parameters);
  }

  @override
  Future<void> logViewItem({
    String? currency,
    double? value,
    List<AnalyticsEventItem>? items,
    Map<String, Object>? parameters,
  }) async {
    if (!await _supported()) return;

    await _instance.logViewItem(
      currency: currency,
      value: value,
      items: items,
      parameters: parameters,
    );
  }

  @override
  Future<void> logViewItemList({
    List<AnalyticsEventItem>? items,
    String? itemListId,
    String? itemListName,
    Map<String, Object>? parameters,
  }) async {
    if (!await _supported()) return;

    await _instance.logViewItemList(
      items: items,
      itemListId: itemListId,
      itemListName: itemListName,
      parameters: parameters,
    );
  }

  @override
  Future<void> logViewPromotion({
    String? creativeName,
    String? creativeSlot,
    List<AnalyticsEventItem>? items,
    String? locationId,
    String? promotionId,
    String? promotionName,
    Map<String, Object>? parameters,
  }) async {
    if (!await _supported()) return;

    await _instance.logViewPromotion(
      creativeName: creativeName,
      creativeSlot: creativeSlot,
      items: items,
      locationId: locationId,
      promotionId: promotionId,
      promotionName: promotionName,
      parameters: parameters,
    );
  }

  @override
  Future<void> logViewSearchResults({
    required String searchTerm,
    Map<String, Object>? parameters,
  }) async {
    if (!await _supported()) return;

    await _instance.logViewSearchResults(
      searchTerm: searchTerm,
      parameters: parameters,
    );
  }

  @override
  Future<void> logRefund({
    String? currency,
    String? coupon,
    double? value,
    double? tax,
    double? shipping,
    String? transactionId,
    String? affiliation,
    List<AnalyticsEventItem>? items,
    Map<String, Object>? parameters,
  }) async {
    if (!await _supported()) return;

    await _instance.logRefund(
      currency: currency,
      coupon: coupon,
      value: value,
      tax: tax,
      shipping: shipping,
      transactionId: transactionId,
      affiliation: affiliation,
      items: items,
      parameters: parameters,
    );
  }

  @override
  Future<void> logInAppPurchase({
    String? currency,
    bool? freeTrial,
    double? price,
    bool? priceIsDiscounted,
    String? productID,
    String? productName,
    int? quantity,
    bool? subscription,
    num? value,
  }) async {
    if (!await _supported()) return;

    await _instance.logInAppPurchase(
      currency: currency,
      freeTrial: freeTrial,
      price: price,
      priceIsDiscounted: priceIsDiscounted,
      productID: productID,
      productName: productName,
      quantity: quantity,
      subscription: subscription,
      value: value,
    );
  }

  @override
  Future<void> logTransaction(String transactionId) async {
    if (!await _supported()) return;

    await _instance.logTransaction(transactionId);
  }

  @override
  Future<void> setSessionTimeoutDuration(Duration timeout) async {
    if (!await _supported()) return;

    await _instance.setSessionTimeoutDuration(timeout);
  }

  @override
  Future<void> initiateOnDeviceConversionMeasurementWithEmailAddress(
    String emailAddress,
  ) async {
    if (!await _supported()) return;

    await _instance.initiateOnDeviceConversionMeasurementWithEmailAddress(
      emailAddress,
    );
  }

  @override
  Future<void> initiateOnDeviceConversionMeasurementWithPhoneNumber(
    String phoneNumber,
  ) async {
    if (!await _supported()) return;

    await _instance.initiateOnDeviceConversionMeasurementWithPhoneNumber(
      phoneNumber,
    );
  }

  @override
  Future<void> initiateOnDeviceConversionMeasurementWithHashedEmailAddress(
    String hashedEmailAddress,
  ) async {
    if (!await _supported()) return;

    await _instance.initiateOnDeviceConversionMeasurementWithHashedEmailAddress(
      hashedEmailAddress,
    );
  }

  @override
  Future<void> initiateOnDeviceConversionMeasurementWithHashedPhoneNumber(
    String hashedPhoneNumber,
  ) async {
    if (!await _supported()) return;

    await _instance.initiateOnDeviceConversionMeasurementWithHashedPhoneNumber(
      hashedPhoneNumber,
    );
  }
}
