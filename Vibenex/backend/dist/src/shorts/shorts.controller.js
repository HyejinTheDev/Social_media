"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ShortsController = void 0;
const common_1 = require("@nestjs/common");
const shorts_service_1 = require("./shorts.service");
const jwt_auth_guard_1 = require("../auth/guards/jwt-auth.guard");
const swagger_1 = require("@nestjs/swagger");
const platform_express_1 = require("@nestjs/platform-express");
const multer_1 = require("multer");
const cloudinary_service_1 = require("../cloudinary/cloudinary.service");
const uploadOptions = {
    storage: (0, multer_1.memoryStorage)(),
    limits: { fileSize: 100 * 1024 * 1024 },
    fileFilter: (_, file, cb) => {
        if (file.mimetype.startsWith('image/') || file.mimetype.startsWith('video/')) {
            cb(null, true);
        }
        else {
            cb(new Error('Chỉ hỗ trợ file ảnh hoặc video'), false);
        }
    },
};
let ShortsController = class ShortsController {
    shortsService;
    cloudinaryService;
    constructor(shortsService, cloudinaryService) {
        this.shortsService = shortsService;
        this.cloudinaryService = cloudinaryService;
    }
    getFeed(page = '1', limit = '10') {
        return this.shortsService.getFeed(parseInt(page, 10), parseInt(limit, 10));
    }
    getShortById(id) {
        return this.shortsService.getShortById(id);
    }
    createShort(req, body) {
        return this.shortsService.createShort(req.user.sub, body.videoUrl, body.caption, body.thumbnailUrl);
    }
    async uploadMedia(file) {
        const isVideo = file.mimetype.startsWith('video/');
        const result = isVideo
            ? await this.cloudinaryService.uploadVideo(file)
            : await this.cloudinaryService.uploadImage(file);
        return {
            url: result.secure_url,
            type: isVideo ? 'video' : 'image',
        };
    }
    toggleLike(req, id) {
        return this.shortsService.toggleLike(id, req.user.sub);
    }
    getComments(id) {
        return this.shortsService.getComments(id);
    }
    createComment(req, id, body) {
        return this.shortsService.createComment(id, req.user.sub, body.content, body.parentId);
    }
};
exports.ShortsController = ShortsController;
__decorate([
    (0, common_1.Get)('feed'),
    (0, swagger_1.ApiOperation)({ summary: 'Get shorts feed' }),
    __param(0, (0, common_1.Query)('page')),
    __param(1, (0, common_1.Query)('limit')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String]),
    __metadata("design:returntype", void 0)
], ShortsController.prototype, "getFeed", null);
__decorate([
    (0, common_1.Get)(':id'),
    (0, swagger_1.ApiOperation)({ summary: 'Get short by id' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], ShortsController.prototype, "getShortById", null);
__decorate([
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    (0, swagger_1.ApiBearerAuth)(),
    (0, common_1.Post)(),
    (0, swagger_1.ApiOperation)({ summary: 'Create a new short' }),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", void 0)
], ShortsController.prototype, "createShort", null);
__decorate([
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    (0, swagger_1.ApiBearerAuth)(),
    (0, common_1.Post)('upload'),
    (0, swagger_1.ApiOperation)({ summary: 'Upload short video or thumbnail to Cloudinary' }),
    (0, common_1.UseInterceptors)((0, platform_express_1.FileInterceptor)('file', uploadOptions)),
    __param(0, (0, common_1.UploadedFile)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], ShortsController.prototype, "uploadMedia", null);
__decorate([
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    (0, swagger_1.ApiBearerAuth)(),
    (0, common_1.Post)(':id/like'),
    (0, swagger_1.ApiOperation)({ summary: 'Toggle like on a short' }),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String]),
    __metadata("design:returntype", void 0)
], ShortsController.prototype, "toggleLike", null);
__decorate([
    (0, common_1.Get)(':id/comments'),
    (0, swagger_1.ApiOperation)({ summary: 'Get comments for a short' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], ShortsController.prototype, "getComments", null);
__decorate([
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    (0, swagger_1.ApiBearerAuth)(),
    (0, common_1.Post)(':id/comments'),
    (0, swagger_1.ApiOperation)({ summary: 'Create a comment on a short' }),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Param)('id')),
    __param(2, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String, Object]),
    __metadata("design:returntype", void 0)
], ShortsController.prototype, "createComment", null);
exports.ShortsController = ShortsController = __decorate([
    (0, swagger_1.ApiTags)('shorts'),
    (0, common_1.Controller)('shorts'),
    __metadata("design:paramtypes", [shorts_service_1.ShortsService,
        cloudinary_service_1.CloudinaryService])
], ShortsController);
//# sourceMappingURL=shorts.controller.js.map