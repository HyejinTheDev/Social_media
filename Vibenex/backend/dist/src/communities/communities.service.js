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
Object.defineProperty(exports, "__esModule", { value: true });
exports.CommunitiesService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
let CommunitiesService = class CommunitiesService {
    prisma;
    constructor(prisma) {
        this.prisma = prisma;
    }
    async findAll(page, limit, search) {
        const where = search
            ? {
                OR: [
                    { name: { contains: search, mode: 'insensitive' } },
                    { description: { contains: search, mode: 'insensitive' } },
                ],
            }
            : {};
        const [communities, total] = await Promise.all([
            this.prisma.community.findMany({
                where,
                skip: (page - 1) * limit,
                take: limit,
                orderBy: { createdAt: 'desc' },
            }),
            this.prisma.community.count({ where }),
        ]);
        return { communities, total };
    }
    async findById(id) {
        const community = await this.prisma.community.findUnique({ where: { id } });
        if (!community)
            throw new common_1.NotFoundException('Community not found');
        return community;
    }
    async create(userId, data) {
        const slug = data.name
            .toLowerCase()
            .replace(/[^a-z0-9]+/g, '-')
            .replace(/^-|-$/g, '')
            + '-' + Date.now().toString(36);
        const community = await this.prisma.community.create({
            data: {
                name: data.name,
                slug,
                description: data.description,
                isPublic: data.isPublic ?? true,
                memberCount: 1,
                members: {
                    create: {
                        userId,
                        role: 'OWNER',
                    },
                },
                channels: {
                    create: {
                        name: 'general',
                        type: 'TEXT',
                        description: 'General discussion',
                        position: 0,
                    },
                },
            },
            include: {
                channels: true,
            },
        });
        return community;
    }
    async getChannels(communityId) {
        const community = await this.prisma.community.findUnique({ where: { id: communityId } });
        if (!community)
            throw new common_1.NotFoundException('Community not found');
        return this.prisma.channel.findMany({
            where: { communityId },
            orderBy: { position: 'asc' },
        });
    }
    async join(communityId, userId) {
        const community = await this.prisma.community.findUnique({ where: { id: communityId } });
        if (!community)
            throw new common_1.NotFoundException('Community not found');
        if (!community.isPublic)
            throw new common_1.ForbiddenException('This community is private');
        const existing = await this.prisma.communityMember.findUnique({
            where: { communityId_userId: { communityId, userId } },
        });
        if (existing)
            return existing;
        const member = await this.prisma.communityMember.create({
            data: { communityId, userId, role: 'MEMBER' },
        });
        await this.prisma.community.update({
            where: { id: communityId },
            data: { memberCount: { increment: 1 } },
        });
        return member;
    }
};
exports.CommunitiesService = CommunitiesService;
exports.CommunitiesService = CommunitiesService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], CommunitiesService);
//# sourceMappingURL=communities.service.js.map