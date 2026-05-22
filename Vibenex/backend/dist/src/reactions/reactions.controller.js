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
exports.ReactionsController = void 0;
const common_1 = require("@nestjs/common");
const swagger_1 = require("@nestjs/swagger");
const reactions_service_1 = require("./reactions.service");
const jwt_auth_guard_1 = require("../auth/guards/jwt-auth.guard");
let ReactionsController = class ReactionsController {
    reactionsService;
    constructor(reactionsService) {
        this.reactionsService = reactionsService;
    }
    toggleDiscussionReaction(req, discussionId, body) {
        return this.reactionsService.toggleDiscussionReaction(discussionId, req.user.sub, body.emoji);
    }
    toggleReplyReaction(req, replyId, body) {
        return this.reactionsService.toggleReplyReaction(replyId, req.user.sub, body.emoji);
    }
    getDiscussionReactions(req, discussionId) {
        return this.reactionsService.getDiscussionReactions(discussionId, req.user.sub);
    }
    getReplyReactions(req, replyId) {
        return this.reactionsService.getReplyReactions(replyId, req.user.sub);
    }
};
exports.ReactionsController = ReactionsController;
__decorate([
    (0, common_1.Post)('discussions/:discussionId'),
    (0, swagger_1.ApiOperation)({ summary: 'Toggle emoji reaction on a discussion' }),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Param)('discussionId')),
    __param(2, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String, Object]),
    __metadata("design:returntype", void 0)
], ReactionsController.prototype, "toggleDiscussionReaction", null);
__decorate([
    (0, common_1.Post)('replies/:replyId'),
    (0, swagger_1.ApiOperation)({ summary: 'Toggle emoji reaction on a reply' }),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Param)('replyId')),
    __param(2, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String, Object]),
    __metadata("design:returntype", void 0)
], ReactionsController.prototype, "toggleReplyReaction", null);
__decorate([
    (0, common_1.Get)('discussions/:discussionId'),
    (0, swagger_1.ApiOperation)({ summary: 'Get reaction summary for a discussion' }),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Param)('discussionId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String]),
    __metadata("design:returntype", void 0)
], ReactionsController.prototype, "getDiscussionReactions", null);
__decorate([
    (0, common_1.Get)('replies/:replyId'),
    (0, swagger_1.ApiOperation)({ summary: 'Get reaction summary for a reply' }),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Param)('replyId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String]),
    __metadata("design:returntype", void 0)
], ReactionsController.prototype, "getReplyReactions", null);
exports.ReactionsController = ReactionsController = __decorate([
    (0, swagger_1.ApiTags)('Reactions'),
    (0, common_1.Controller)('reactions'),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    (0, swagger_1.ApiBearerAuth)(),
    __metadata("design:paramtypes", [reactions_service_1.ReactionsService])
], ReactionsController);
//# sourceMappingURL=reactions.controller.js.map