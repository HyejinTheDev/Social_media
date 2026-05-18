import { Injectable } from '@nestjs/common';
import { v2 as cloudinary } from 'cloudinary';
import { UploadApiErrorResponse, UploadApiResponse } from 'cloudinary';
import * as streamifier from 'streamifier';

@Injectable()
export class CloudinaryService {
  uploadImage(
    file: Express.Multer.File,
  ): Promise<UploadApiResponse | UploadApiErrorResponse> {
    return new Promise((resolve, reject) => {
      const upload = cloudinary.uploader.upload_stream(
        { folder: 'vibenex/images' },
        (error, result) => {
          if (error) return reject(error);
          resolve(result!);
        },
      );
      streamifier.createReadStream(file.buffer).pipe(upload);
    });
  }

  uploadVideo(
    file: Express.Multer.File,
  ): Promise<UploadApiResponse | UploadApiErrorResponse> {
    return new Promise((resolve, reject) => {
      const upload = cloudinary.uploader.upload_stream(
        { folder: 'vibenex/videos', resource_type: 'video' },
        (error, result) => {
          if (error) return reject(error);
          resolve(result!);
        },
      );
      streamifier.createReadStream(file.buffer).pipe(upload);
    });
  }
}
