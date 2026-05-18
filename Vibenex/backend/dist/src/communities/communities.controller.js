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
exports.CommunitiesController = void 0;
const common_1 = require("@nestjs/common");
const communities_service_1 = require("./communities.service");
const jwt_auth_guard_1 = require("../auth/guards/jwt-auth.guard");
let CommunitiesController = class CommunitiesController {
    communitiesService;
    constructor(communitiesService) {
        this.communitiesService = communitiesService;
    }
    findAll(page = '1', limit = '20', search) {
        return this.communitiesService.findAll(parseInt(page), parseInt(limit), search);
    }
    findOne(id) {
        return this.communitiesService.findById(id);
    }
    create(req, body) {
        return this.communitiesService.create(req.user.sub, body);
    }
    getChannels(communityId) {
        return this.communitiesService.getChannels(communityId);
    }
    join(req, communityId) {
        return this.communitiesService.join(communityId, req.user.sub);
    }
    leave(req, communityId) {
        return this.communitiesService.leave(communityId, req.user.sub);
    }
    update(req, id, body) {
        return this.communitiesService.update(id, req.user.sub, body);
    }
    remove(req, id) {
        return this.communitiesService.remove(id, req.user.sub);
    }
    getChannelMessages(channelId, page = '1', limit = '20') {
        return this.communitiesService.getChannelMessages(channelId, parseInt(page), parseInt(limit));
    }
};
exports.CommunitiesController = CommunitiesController;
__decorate([
    (0, common_1.Get)(),
    __param(0, (0, common_1.Query)('page')),
    __param(1, (0, common_1.Query)('limit')),
    __param(2, (0, common_1.Query)('search')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object, String]),
    __metadata("design:returntype", void 0)
], CommunitiesController.prototype, "findAll", null);
__decorate([
    (0, common_1.Get)(':id'),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], CommunitiesController.prototype, "findOne", null);
__decorate([
    (0, common_1.Post)(),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", void 0)
], CommunitiesController.prototype, "create", null);
__decorate([
    (0, common_1.Get)(':communityId/channels'),
    __param(0, (0, common_1.Param)('communityId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], CommunitiesController.prototype, "getChannels", null);
__decorate([
    (0, common_1.Post)(':communityId/join'),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Param)('communityId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String]),
    __metadata("design:returntype", void 0)
], CommunitiesController.prototype, "join", null);
__decorate([
    (0, common_1.Post)(':communityId/leave'),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Param)('communityId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String]),
    __metadata("design:returntype", void 0)
], CommunitiesController.prototype, "leave", null);
__decorate([
    (0, common_1.Patch)(':id'),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Param)('id')),
    __param(2, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String, Object]),
    __metadata("design:returntype", void 0)
], CommunitiesController.prototype, "update", null);
__decorate([
    (0, common_1.Delete)(':id'),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String]),
    __metadata("design:returntype", void 0)
], CommunitiesController.prototype, "remove", null);
__decorate([
    (0, common_1.Get)('channels/:channelId/messages'),
    __param(0, (0, common_1.Param)('channelId')),
    __param(1, (0, common_1.Query)('page')),
    __param(2, (0, common_1.Query)('limit')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object, Object]),
    __metadata("design:returntype", void 0)
], CommunitiesController.prototype, "getChannelMessages", null);
exports.CommunitiesController = CommunitiesController = __decorate([
    (0, common_1.Controller)('communities'),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    __metadata("design:paramtypes", [communities_service_1.CommunitiesService])
], CommunitiesController);
//# sourceMappingURL=communities.controller.js.map