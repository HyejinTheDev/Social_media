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
exports.CommentsController = void 0;
const common_1 = require("@nestjs/common");
const comments_service_1 = require("./comments.service");
const create_comment_dto_1 = require("./dto/create-comment.dto");
const jwt_auth_guard_1 = require("../auth/guards/jwt-auth.guard");
const swagger_1 = require("@nestjs/swagger");
let CommentsController = class CommentsController {
    commentsService;
    constructor(commentsService) {
        this.commentsService = commentsService;
    }
    create(req, postId, createCommentDto) {
        return this.commentsService.create(req.user.sub, postId, createCommentDto);
    }
    getComments(postId, page, limit) {
        return this.commentsService.getComments(postId, page ? parseInt(page, 10) : 1, limit ? parseInt(limit, 10) : 20);
    }
    remove(req, id) {
        return this.commentsService.remove(req.user.sub, id);
    }
};
exports.CommentsController = CommentsController;
__decorate([
    (0, common_1.Post)('posts/:postId/comments'),
    (0, swagger_1.ApiOperation)({ summary: 'Add a comment to a post' }),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Param)('postId')),
    __param(2, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String, create_comment_dto_1.CreateCommentDto]),
    __metadata("design:returntype", void 0)
], CommentsController.prototype, "create", null);
__decorate([
    (0, common_1.Get)('posts/:postId/comments'),
    (0, swagger_1.ApiOperation)({ summary: 'Get comments of a post' }),
    __param(0, (0, common_1.Param)('postId')),
    __param(1, (0, common_1.Query)('page')),
    __param(2, (0, common_1.Query)('limit')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String, String]),
    __metadata("design:returntype", void 0)
], CommentsController.prototype, "getComments", null);
__decorate([
    (0, common_1.Delete)('comments/:id'),
    (0, swagger_1.ApiOperation)({ summary: 'Delete a comment' }),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String]),
    __metadata("design:returntype", void 0)
], CommentsController.prototype, "remove", null);
exports.CommentsController = CommentsController = __decorate([
    (0, swagger_1.ApiTags)('Comments'),
    (0, common_1.Controller)(),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    (0, swagger_1.ApiBearerAuth)(),
    __metadata("design:paramtypes", [comments_service_1.CommentsService])
], CommentsController);
//# sourceMappingURL=comments.controller.js.map