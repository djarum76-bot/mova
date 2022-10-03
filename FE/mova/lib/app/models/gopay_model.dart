// To parse this JSON data, do
//
//     final gopayModel = gopayModelFromJson(jsonString);

import 'dart:convert';

GopayModel gopayModelFromJson(String str) => GopayModel.fromJson(json.decode(str));

String gopayModelToJson(GopayModel data) => json.encode(data.toJson());

class GopayModel {
  GopayModel({
    this.transactionId,
    this.orderId,
    this.grossAmount,
    this.paymentType,
    this.transactionTime,
    this.transactionStatus,
    this.fraudStatus,
    this.maskedCard,
    this.statusCode,
    this.bank,
    this.statusMessage,
    this.approvalCode,
    this.channelResponseCode,
    this.channelResponseMessage,
    this.currency,
    this.cardType,
    this.redirectUrl,
    this.id,
    this.validationMessages,
    this.installmentTerm,
    this.eci,
    this.savedTokenId,
    this.savedTokenIdExpiredAt,
    this.pointRedeemAmount,
    this.pointRedeemQuantity,
    this.pointBalanceAmount,
    this.permataVaNumber,
    this.vaNumbers,
    this.billKey,
    this.billerCode,
    this.acquirer,
    this.actions,
    this.paymentCode,
    this.store,
    this.qrString,
    this.onUs,
  });

  String? transactionId;
  String? orderId;
  String? grossAmount;
  String? paymentType;
  DateTime? transactionTime;
  String? transactionStatus;
  String? fraudStatus;
  String? maskedCard;
  String? statusCode;
  String? bank;
  String? statusMessage;
  String? approvalCode;
  String? channelResponseCode;
  String? channelResponseMessage;
  String? currency;
  String? cardType;
  String? redirectUrl;
  String? id;
  dynamic validationMessages;
  String? installmentTerm;
  String? eci;
  String? savedTokenId;
  String? savedTokenIdExpiredAt;
  int? pointRedeemAmount;
  int? pointRedeemQuantity;
  String? pointBalanceAmount;
  String? permataVaNumber;
  dynamic vaNumbers;
  String? billKey;
  String? billerCode;
  String? acquirer;
  List<Action>? actions;
  String? paymentCode;
  String? store;
  String? qrString;
  bool? onUs;

  factory GopayModel.fromJson(Map<String, dynamic> json) => GopayModel(
    transactionId: json["transaction_id"],
    orderId: json["order_id"],
    grossAmount: json["gross_amount"],
    paymentType: json["payment_type"],
    transactionTime: DateTime.parse(json["transaction_time"]),
    transactionStatus: json["transaction_status"],
    fraudStatus: json["fraud_status"],
    maskedCard: json["masked_card"],
    statusCode: json["status_code"],
    bank: json["bank"],
    statusMessage: json["status_message"],
    approvalCode: json["approval_code"],
    channelResponseCode: json["channel_response_code"],
    channelResponseMessage: json["channel_response_message"],
    currency: json["currency"],
    cardType: json["card_type"],
    redirectUrl: json["redirect_url"],
    id: json["id"],
    validationMessages: json["validation_messages"],
    installmentTerm: json["installment_term"],
    eci: json["eci"],
    savedTokenId: json["saved_token_id"],
    savedTokenIdExpiredAt: json["saved_token_id_expired_at"],
    pointRedeemAmount: json["point_redeem_amount"],
    pointRedeemQuantity: json["point_redeem_quantity"],
    pointBalanceAmount: json["point_balance_amount"],
    permataVaNumber: json["permata_va_number"],
    vaNumbers: json["va_numbers"],
    billKey: json["bill_key"],
    billerCode: json["biller_code"],
    acquirer: json["acquirer"],
    actions: List<Action>.from(json["actions"].map((x) => Action.fromJson(x))),
    paymentCode: json["payment_code"],
    store: json["store"],
    qrString: json["qr_string"],
    onUs: json["on_us"],
  );

  Map<String, dynamic> toJson() => {
    "transaction_id": transactionId,
    "order_id": orderId,
    "gross_amount": grossAmount,
    "payment_type": paymentType,
    "transaction_time": transactionTime!.toIso8601String(),
    "transaction_status": transactionStatus,
    "fraud_status": fraudStatus,
    "masked_card": maskedCard,
    "status_code": statusCode,
    "bank": bank,
    "status_message": statusMessage,
    "approval_code": approvalCode,
    "channel_response_code": channelResponseCode,
    "channel_response_message": channelResponseMessage,
    "currency": currency,
    "card_type": cardType,
    "redirect_url": redirectUrl,
    "id": id,
    "validation_messages": validationMessages,
    "installment_term": installmentTerm,
    "eci": eci,
    "saved_token_id": savedTokenId,
    "saved_token_id_expired_at": savedTokenIdExpiredAt,
    "point_redeem_amount": pointRedeemAmount,
    "point_redeem_quantity": pointRedeemQuantity,
    "point_balance_amount": pointBalanceAmount,
    "permata_va_number": permataVaNumber,
    "va_numbers": vaNumbers,
    "bill_key": billKey,
    "biller_code": billerCode,
    "acquirer": acquirer,
    "actions": List<dynamic>.from(actions!.map((x) => x.toJson())),
    "payment_code": paymentCode,
    "store": store,
    "qr_string": qrString,
    "on_us": onUs,
  };
}

class Action {
  Action({
    this.name,
    this.method,
    this.url,
    this.fields,
  });

  String? name;
  String? method;
  String? url;
  dynamic fields;

  factory Action.fromJson(Map<String, dynamic> json) => Action(
    name: json["name"],
    method: json["method"],
    url: json["url"],
    fields: json["fields"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "method": method,
    "url": url,
    "fields": fields,
  };
}