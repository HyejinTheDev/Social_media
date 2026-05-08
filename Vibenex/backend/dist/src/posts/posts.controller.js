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
exports.PostsController = void 0;
const common_1 = require("@nestjs/common");
const posts_service_1 = require("./posts.service");
const create_post_dto_1 = require("./dto/create-post.dto");
const jwt_auth_guard_1 = require("../auth/guards/jwt-auth.guard");
const swagger_1 = require("@nestjs/swagger");
const platform_express_1 = require("@nestjs/platform-express");
const multer_1 = require("multer");
const path_1 = require("path");
const uuid_1 = require("uuid");
const storage = (0, multer_1.diskStorage)({
    destination: './uploads/posts',
    filename: (_, file, cb) => {
        const uniqueName = `${(0, uuid_1.v4)()}${(0, path_1.extname)(file.originalname)}`;
        cb(null, uniqueName);
    },
});
const fileFilter = (_, file, cb) => {
    if (file.mimetype.startsWith('image/') || file.mimetype.startsWith('video/')) {
        cb(null, true);
    }
    else {
        cb(new Error('Chỉ hỗ trợ file ảnh hoặc video'), false);
    }
};
let PostsController = class PostsController {
    postsService;
    constructor(postsService) {
        this.postsService = postsService;
    }
    create(req, createPostDto, files) {
        const fileUrls = {};
        if (files?.images) {
            fileUrls.images = files.images.map(f => `/uploads/posts/${f.filename}`);
        }
        if (files?.video) {
            fileUrls.video = `/uploads/posts/${files.video[0].filename}`;
        }
        if (files?.thumbnail) {
            fileUrls.thumbnail = `/uploads/posts/${files.thumbnail[0].filename}`;
        }
        return this.postsService.create(req.user.sub, createPostDto, fileUrls);
    }
    findAll(page, limit) {
        return this.postsService.getFeed(page ? parseInt(page, 10) : 1, limit ? parseInt(limit, 10) : 10);
    }
    findByUser(userId, page, limit) {
        return this.postsService.getUserPosts(userId, page ? parseInt(page, 10) : 1, limit ? parseInt(limit, 10) : 10);
    }
    findOne(id) {
        return this.postsService.getPostById(id);
    }
    remove(req, id) {
        return this.postsService.remove(req.user.sub, id);
    }
    toggleLike(req, id) {
        return this.postsService.toggleLike(req.user.sub, id);
    }
    getLikeStatus(req, id) {
        return this.postsService.getLikeStatus(req.user.sub, id);
    }
};
exports.PostsController = PostsController;
__decorate([
    (0, common_1.Post)(),
    (0, swagger_1.ApiOperation)({ summary: 'Create a new post' }),
    (0, swagger_1.ApiConsumes)('multipart/form-data'),
    (0, common_1.UseInterceptors)((0, platform_express_1.FileFieldsInterceptor)([
        { name: 'images', maxCount: 10 },
        { name: 'video', maxCount: 1 },
        { name: 'thumbnail', maxCount: 1 },
    ], { storage, fileFilter, limits: { fileSize: 50 * 1024 * 1024 } })),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Body)()),
    __param(2, (0, common_1.UploadedFiles)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, create_post_dto_1.CreatePostDto, Object]),
    __metadata("design:returntype", void 0)
], PostsController.prototype, "create", null);
__decorate([
    (0, common_1.Get)(),
    (0, swagger_1.ApiOperation)({ summary: 'Get feed posts' }),
    __param(0, (0, common_1.Query)('page')),
    __param(1, (0, common_1.Query)('limit')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String]),
    __metadata("design:returntype", void 0)
], PostsController.prototype, "findAll", null);
__decorate([
    (0, common_1.Get)('user/:userId'),
    (0, swagger_1.ApiOperation)({ summary: 'Get user posts' }),
    __param(0, (0, common_1.Param)('userId')),
    __param(1, (0, common_1.Query)('page')),
    __param(2, (0, common_1.Query)('limit')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String, String]),
    __metadata("design:returntype", void 0)
], PostsController.prototype, "findByUser", null);
__decorate([
    (0, common_1.Get)(':id'),
    (0, swagger_1.ApiOperation)({ summary: 'Get post by ID' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], PostsController.prototype, "findOne", null);
__decorate([
    (0, common_1.Delete)(':id'),
    (0, swagger_1.ApiOperation)({ summary: 'Delete a post' }),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String]),
    __metadata("design:returntype", void 0)
], PostsController.prototype, "remove", null);
__decorate([
    (0, common_1.Post)(':id/like'),
    (0, swagger_1.ApiOperation)({ summary: 'Toggle like status for a post' }),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String]),
    __metadata("design:returntype", void 0)
], PostsController.prototype, "toggleLike", null);
__decorate([
    (0, common_1.Get)(':id/like-status'),
    (0, swagger_1.ApiOperation)({ summary: 'Check if current user liked a post' }),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String]),
    __metadata("design:returntype", void 0)
], PostsController.prototype, "getLikeStatus", null);
exports.PostsController = PostsController = __decorate([
    (0, swagger_1.ApiTags)('Posts'),
    (0, common_1.Controller)('posts'),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    (0, swagger_1.ApiBearerAuth)(),
    __metadata("design:paramtypes", [posts_service_1.PostsService])
], PostsController);
//# sourceMappingURL=posts.controller.js.map