import 'dart:typed_data';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';

class CloudinaryService {

  static final cloudinary = CloudinaryPublic(
      dotenv.env['CLOUD_NAME']!, dotenv.env['UPLOAD_PRESET']!, cache: false);

  Future<String> uploadImageFile(XFile imageFile, {String? folder}) async {
      CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
              imageFile.path, resourceType: CloudinaryResourceType.Image, folder: folder));
      return response.secureUrl;
  }
  Future<String> uploadImageBytes(Uint8List bytes,
      {String? folder, String? publicId}) async {

    final String localIdentifier = publicId ?? DateTime.now().millisecondsSinceEpoch.toString();

    CloudinaryResponse response = await cloudinary.uploadFile(
      CloudinaryFile.fromBytesData(
        bytes,
        resourceType: CloudinaryResourceType.Image,
        folder: folder,
        publicId: publicId,
        identifier: localIdentifier,
      ),
    );
    return response.secureUrl;
  }
}