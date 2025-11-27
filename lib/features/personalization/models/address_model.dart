import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/utils/formatters/formaters.dart';

class AddressModel {
  String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final DateTime? dateTime;
  final bool selectedAddress;

  /// Constructor
  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.dateTime,
    this.selectedAddress = true,
  });

  /// Getter
  String get formattedPhoneNo => Formaters.formatPhoneNumber(phoneNumber);

  /// Static factory cho empty AddressModel
  static AddressModel empty() => AddressModel(
    id: '',
    name: '',
    phoneNumber: '',
    street: '',
    city: '',
    state: '',
    postalCode: '',
    country: '',
    dateTime: null,
  );

  /// Convert model to Json
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'PhoneNumber': phoneNumber,
      'Street': street,
      'City': city,
      'State': state,
      'PostalCode': postalCode,
      'Country': country,
      'DateTime': DateTime.now(),
      'SelectedAddress': selectedAddress,
    };
  }

  /// Factory constructor từ Map
  factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
      id: data['Id'] as String,
      name: data['Name'] as String,
      phoneNumber: data['PhoneNumber'] as String,
      street: data['Street'] as String,
      city: data['City'] as String,
      state: data['State'] as String,
      postalCode: data['PostalCode'] as String,
      country: data['Country'] as String,
      dateTime: (data['DateTime'] as Timestamp).toDate(),
      selectedAddress: data['SelectedAddress'] as bool,
    );
  }

  /// Factory constructor từ DocumentSnapshot
  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return AddressModel(
      id: snapshot.id,
      name: data['Name'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      street: data['Street'] ?? '',
      city: data['City'] ?? '',
      state: data['State'] ?? '',
      postalCode: data['PostalCode'] ?? '',
      country: data['Country'] ?? '',
      dateTime: (data['DateTime'] as Timestamp).toDate(),
      selectedAddress: data['SelectedAddress'] as bool,
    );
  }

  /// Override hàm toString
  @override
  String toString() {
    return '$street, $city, $state $postalCode, $country';
  }
}