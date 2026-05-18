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
exports.AdminController = void 0;
const common_1 = require("@nestjs/common");
const swagger_1 = require("@nestjs/swagger");
const jwt_auth_guard_1 = require("../auth/guards/jwt-auth.guard");
const admin_guard_1 = require("./guards/admin.guard");
const admin_service_1 = require("./admin.service");
let AdminController = class AdminController {
    adminService;
    constructor(adminService) {
        this.adminService = adminService;
    }
    getStats() {
        return this.adminService.getStats();
    }
    getUsers(page, search) {
        return this.adminService.getUsers(Number(page) || 1, 20, search);
    }
    deleteUser(id) {
        return this.adminService.deleteUser(id);
    }
    toggleVerify(id) {
        return this.adminService.toggleVerify(id);
    }
    getPosts(page, search) {
        return this.adminService.getPosts(Number(page) || 1, 20, search);
    }
    deletePost(id) {
        return this.adminService.deletePost(id);
    }
    getShorts(page) {
        return this.adminService.getShorts(Number(page) || 1);
    }
    deleteShort(id) {
        return this.adminService.deleteShort(id);
    }
    getCommunities(page, search) {
        return this.adminService.getCommunities(Number(page) || 1, 20, search);
    }
    deleteCommunity(id) {
        return this.adminService.deleteCommunity(id);
    }
};
exports.AdminController = AdminController;
__decorate([
    (0, common_1.Get)('stats'),
    (0, swagger_1.ApiOperation)({ summary: 'Get dashboard statistics' }),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", void 0)
], AdminController.prototype, "getStats", null);
__decorate([
    (0, common_1.Get)('users'),
    (0, swagger_1.ApiOperation)({ summary: 'List all users' }),
    (0, swagger_1.ApiQuery)({ name: 'page', required: false }),
    (0, swagger_1.ApiQuery)({ name: 'search', required: false }),
    __param(0, (0, common_1.Query)('page')),
    __param(1, (0, common_1.Query)('search')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String]),
    __metadata("design:returntype", void 0)
], AdminController.prototype, "getUsers", null);
__decorate([
    (0, common_1.Delete)('users/:id'),
    (0, swagger_1.ApiOperation)({ summary: 'Delete a user' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], AdminController.prototype, "deleteUser", null);
__decorate([
    (0, common_1.Patch)('users/:id/verify'),
    (0, swagger_1.ApiOperation)({ summary: 'Toggle user verified status' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], AdminController.prototype, "toggleVerify", null);
__decorate([
    (0, common_1.Get)('posts'),
    (0, swagger_1.ApiOperation)({ summary: 'List all posts' }),
    (0, swagger_1.ApiQuery)({ name: 'page', required: false }),
    (0, swagger_1.ApiQuery)({ name: 'search', required: false }),
    __param(0, (0, common_1.Query)('page')),
    __param(1, (0, common_1.Query)('search')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String]),
    __metadata("design:returntype", void 0)
], AdminController.prototype, "getPosts", null);
__decorate([
    (0, common_1.Delete)('posts/:id'),
    (0, swagger_1.ApiOperation)({ summary: 'Delete a post' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], AdminController.prototype, "deletePost", null);
__decorate([
    (0, common_1.Get)('shorts'),
    (0, swagger_1.ApiOperation)({ summary: 'List all shorts' }),
    (0, swagger_1.ApiQuery)({ name: 'page', required: false }),
    __param(0, (0, common_1.Query)('page')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], AdminController.prototype, "getShorts", null);
__decorate([
    (0, common_1.Delete)('shorts/:id'),
    (0, swagger_1.ApiOperation)({ summary: 'Delete a short' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], AdminController.prototype, "deleteShort", null);
__decorate([
    (0, common_1.Get)('communities'),
    (0, swagger_1.ApiOperation)({ summary: 'List all communities' }),
    (0, swagger_1.ApiQuery)({ name: 'page', required: false }),
    (0, swagger_1.ApiQuery)({ name: 'search', required: false }),
    __param(0, (0, common_1.Query)('page')),
    __param(1, (0, common_1.Query)('search')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String]),
    __metadata("design:returntype", void 0)
], AdminController.prototype, "getCommunities", null);
__decorate([
    (0, common_1.Delete)('communities/:id'),
    (0, swagger_1.ApiOperation)({ summary: 'Delete a community' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], AdminController.prototype, "deleteCommunity", null);
exports.AdminController = AdminController = __decorate([
    (0, swagger_1.ApiTags)('Admin'),
    (0, common_1.Controller)('admin'),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard, admin_guard_1.AdminGuard),
    (0, swagger_1.ApiBearerAuth)(),
    __metadata("design:paramtypes", [admin_service_1.AdminService])
], AdminController);
//# sourceMappingURL=admin.controller.js.map