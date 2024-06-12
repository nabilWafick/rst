// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:rst/modules/definitions/agents/models/agent/agent.model.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';
import 'package:rst/modules/definitions/products/models/product/product.model.dart';

class Stock {
  final int? id;
  final Product product;
  final int initialQuantity;
  final int? inputQuantity;
  final int? outputQuantity;
  final int stockQuantity;
  final String? movementType;
  final Card? card;
  final Agent agent;
  final DateTime createdAt;
  final DateTime updatedAt;
  Stock({
    this.id,
    required this.product,
    required this.initialQuantity,
    this.inputQuantity,
    this.outputQuantity,
    required this.stockQuantity,
    this.movementType,
    this.card,
    required this.agent,
    required this.createdAt,
    required this.updatedAt,
  });

  Stock copyWith({
    int? id,
    Product? product,
    int? initialQuantity,
    int? inputQuantity,
    int? outputQuantity,
    int? stockQuantity,
    String? movementType,
    Card? card,
    Agent? agent,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Stock(
      id: id ?? this.id,
      product: product ?? this.product,
      initialQuantity: initialQuantity ?? this.initialQuantity,
      inputQuantity: inputQuantity ?? this.inputQuantity,
      outputQuantity: outputQuantity ?? this.outputQuantity,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      movementType: movementType ?? this.movementType,
      card: card ?? this.card,
      agent: agent ?? this.agent,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': product.id,
      'inputQuantity': inputQuantity,
      'outputQuantity': outputQuantity,
      'cardId': card?.id,
      'agentId': agent.id,
    };
  }

  factory Stock.fromMap(Map<String, dynamic> map) {
    if (map.containsKey('card') && map['card'] != null) {
      map['card']?['type']?['typeProducts'] = [];
    }
    return Stock(
      id: map['id'] != null ? map['id'] as int : null,
      product: Product.fromMap(map['product'] as Map<String, dynamic>),
      initialQuantity: map['initialQuantity'] as int,
      inputQuantity:
          map['inputQuantity'] != null ? map['inputQuantity'] as int : null,
      outputQuantity:
          map['outputQuantity'] != null ? map['outputQuantity'] as int : null,
      stockQuantity: map['stockQuantity'] as int,
      movementType:
          map['movementType'] != null ? map['movementType'] as String : null,
      /*  card: map['card'] != null
          ? Card.fromMap(map['card'] as Map<String, dynamic>)
          : null,*/
      agent: Agent.fromMap(map['agent'] as Map<String, dynamic>),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Stock.fromJson(String source) =>
      Stock.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Stock(id: $id, product: $product, initialQuantity: $initialQuantity, inputQuantity: $inputQuantity, outputQuantity: $outputQuantity, stockQuantity: $stockQuantity, movementType: $movementType, card: $card, agent: $agent, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Stock other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.product == product &&
        other.initialQuantity == initialQuantity &&
        other.inputQuantity == inputQuantity &&
        other.outputQuantity == outputQuantity &&
        other.stockQuantity == stockQuantity &&
        other.movementType == movementType &&
        other.card == card &&
        other.agent == agent &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        product.hashCode ^
        initialQuantity.hashCode ^
        inputQuantity.hashCode ^
        outputQuantity.hashCode ^
        stockQuantity.hashCode ^
        movementType.hashCode ^
        card.hashCode ^
        agent.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

class StockInputmovementType {
  static const String manual = 'Manuelle';
  static const String retrocession = 'Rétrocession';
}

class StockOutputmovementType {
  static const String manual = 'Manuelle';
  static const String normal = 'Normale';
  static const String constraint = 'Contrainte';
}
