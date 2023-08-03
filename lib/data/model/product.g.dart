// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Product _$$_ProductFromJson(Map<String, dynamic> json) => _$_Product(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
      description: json['description'] as String,
      amount: json['amount'] as int,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$$_ProductToJson(_$_Product instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'description': instance.description,
      'amount': instance.amount,
      'price': instance.price,
    };
