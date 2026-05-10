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
exports.FollowController = void 0;
const common_1 = require("@nestjs/common");
const follow_service_1 = require("./follow.service");
const jwt_auth_guard_1 = require("../auth/guards/jwt-auth.guard");
const swagger_1 = require("@nestjs/swagger");
let FollowController = class FollowController {
    followService;
    constructor(followService) {
        this.followService = followService;
    }
    follow(req, userId) {
        return this.followService.follow(req.user.sub, userId);
    }
    unfollow(req, userId) {
        return this.followService.unfollow(req.user.sub, userId);
    }
    getStatus(req, userId) {
        return this.followService.getFollowStatus(req.user.sub, userId);
    }
    getFollowers(userId, page) {
        return this.followService.getFollowers(userId, page ? parseInt(page, 10) : 1);
    }
    getFollowing(userId, page) {
        return this.followService.getFollowing(userId, page ? parseInt(page, 10) : 1);
    }
};
exports.FollowController = FollowController;
__decorate([
    (0, common_1.Post)(':userId'),
    (0, swagger_1.ApiOperation)({ summary: 'Follow a user' }),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Param)('userId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String]),
    __metadata("design:returntype", void 0)
], FollowController.prototype, "follow", null);
__decorate([
    (0, common_1.Delete)(':userId'),
    (0, swagger_1.ApiOperation)({ summary: 'Unfollow a user' }),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Param)('userId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String]),
    __metadata("design:returntype", void 0)
], FollowController.prototype, "unfollow", null);
__decorate([
    (0, common_1.Get)(':userId/status'),
    (0, swagger_1.ApiOperation)({ summary: 'Check follow status' }),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Param)('userId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String]),
    __metadata("design:returntype", void 0)
], FollowController.prototype, "getStatus", null);
__decorate([
    (0, common_1.Get)(':userId/followers'),
    (0, swagger_1.ApiOperation)({ summary: 'Get followers of a user' }),
    __param(0, (0, common_1.Param)('userId')),
    __param(1, (0, common_1.Query)('page')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String]),
    __metadata("design:returntype", void 0)
], FollowController.prototype, "getFollowers", null);
__decorate([
    (0, common_1.Get)(':userId/following'),
    (0, swagger_1.ApiOperation)({ summary: 'Get users that a user follows' }),
    __param(0, (0, common_1.Param)('userId')),
    __param(1, (0, common_1.Query)('page')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String]),
    __metadata("design:returntype", void 0)
], FollowController.prototype, "getFollowing", null);
exports.FollowController = FollowController = __decorate([
    (0, swagger_1.ApiTags)('Follow'),
    (0, common_1.Controller)('follow'),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    (0, swagger_1.ApiBearerAuth)(),
    __metadata("design:paramtypes", [follow_service_1.FollowService])
], FollowController);
//# sourceMappingURL=follow.controller.js.map